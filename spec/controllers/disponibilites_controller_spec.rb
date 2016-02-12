require 'spec_helper'

describe DisponibilitesController do

  # This should return the minimal set of attributes required to create a valid
  # Disponibilite. As you add validations to Disponibilite, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "endroit_id" => "11", "niveau_id" => "12", "date_heure_debut" => DateTime.now + 1.minute, "date_heure_fin" => DateTime.now + 1.hour, "statut" => "waiting", "user_absent_id" => "11", "user_remplacant_id" => "12"} }

  describe "GET index" do
    describe "valid session" do
      before(:each) do
        @user = FactoryGirl.create(:user_admin)
        sign_in @user
        allow(controller).to receive(:authenticate_user!)

        @current_user = double
        @user_id = double

        allow(subject).to receive(:current_user) {@current_user}
        allow(@current_user).to receive(:id) {@user_id}
      end

      it "admin user" do
        disponibilite = double
        date = Date.new(Date.current.year, Date.current.month, 01)

        allow(@current_user).to receive(:role?).with(:admin) {false}
        allow(@current_user).to receive(:role?).with(:super_admin) {true}

        expect(Disponibilite).to receive(:by_date_debut).with(date.strftime("%Y/%m/%d")) {disponibilite}
        expect(disponibilite).to receive(:by_date_fin).with(nil) {disponibilite}
        expect(disponibilite).to receive(:order_by_date_heure_debut) {disponibilite}

        expect(disponibilite).to receive(:page).with(1) {disponibilite}
        expect(disponibilite).to receive(:per).with(20) {disponibilite}

        get :index, {}

        expect(response).to render_template(:index)
      end

      it "permanent user" do
        disponibilite = double
        date = Date.new(Date.current.year, Date.current.month, 01)

        allow(@current_user).to receive(:role?).with(:admin) {false}
        allow(@current_user).to receive(:role?).with(:super_admin) {false}
        allow(@current_user).to receive(:role?).with(:permanent) {true}

        expect(Disponibilite).to receive(:by_user_absent).with(@current_user.id) {disponibilite}
        expect(disponibilite).to receive(:by_date_debut).with(date.strftime("%Y/%m/%d")) {disponibilite}
        expect(disponibilite).to receive(:by_date_fin).with(nil) {disponibilite}
        expect(disponibilite).to receive(:order_by_date_heure_debut) {disponibilite}
        expect(disponibilite).to receive(:page).with(1) {disponibilite}
        expect(disponibilite).to receive(:per).with(20) {disponibilite}

        get :index, {}

        expect(response).to render_template(:index)
      end

      it "remplacant user" do
        disponibilite = double
        date = Date.new(Date.current.year, Date.current.month, 01)

        allow(@current_user).to receive(:role?).with(:admin) {false}
        allow(@current_user).to receive(:role?).with(:super_admin) {false}
        allow(@current_user).to receive(:role?).with(:permanent) {false}
        allow(@current_user).to receive(:role?).with(:remplacant) {true}

        expect(Disponibilite).to receive(:by_user_remplacant).with(@current_user.id) {disponibilite}
        expect(disponibilite).to receive(:by_date_debut).with(date.strftime("%Y/%m/%d")) {disponibilite}
        expect(disponibilite).to receive(:by_date_fin).with(nil) {disponibilite}
        expect(disponibilite).to receive(:order_by_date_heure_debut) {disponibilite}
        expect(disponibilite).to receive(:page).with(1) {disponibilite}
        expect(disponibilite).to receive(:per).with(20) {disponibilite}

        get :index, {}

        expect(response).to render_template(:index)
      end
    end

    it "invalid session" do
      get :index, {}
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "GET new" do
    describe "valid session" do
      describe "user with permitted roles" do
        before(:each) do
          @user = FactoryGirl.create(:user_admin)
          sign_in @user
          allow(controller).to receive(:current_user) { @user }
          allow(controller).to receive(:authenticate_user!)
        end

        it "user is redirected to index when no permanent are available" do
          user_absent = double

          allow(@user).to receive(:role?).with(:super_admin) {true}
          allow(@user).to receive(:role?).with(:admin) {false}

          expect(User).to receive(:where).with(titre: "permanent") {user_absent}

          expect(user_absent).to receive(:blank?) {true}

          get :new, {}

          expect(response).to redirect_to(disponibilites_url)
        end

        it "display new disponibilite" do
          user_absent = double

          allow(@user).to receive(:role?).with(:super_admin) {true}
          allow(@user).to receive(:role?).with(:admin) {false}

          expect(User).to receive(:where).with(titre: "permanent") {user_absent}

          expect(user_absent).to receive(:blank?) {false}

          get :new, {}
          expect(response).to render_template(:new)
        end

        it "user permanent" do
          user_absent = double

          allow(@user).to receive(:role?).with(:super_admin) {false}
          allow(@user).to receive(:role?).with(:admin) {false}
          allow(@user).to receive(:role?).with(:permanent) {true}

          expect(User).to receive(:where).with(id: @user.id) {user_absent}

          expect(user_absent).to receive(:blank?) {false}

          get :new, {}
          expect(response).to render_template(:new)
        end
      end
      it "user without roles" do
        user = FactoryGirl.create(:user_admin)
        role = FactoryGirl.create(:role_remplacant)
        user.roles= [role]

        sign_in user

        get :new, {}

        is_expected.to redirect_to(root_url)
      end
    end
    it "invalid session" do
      get :new, {}

      is_expected.to redirect_to(new_user_session_path)
    end
  end

  describe "GET edit" do
    describe "valid session" do
      describe "user with permitted roles" do
        it "success" do
          @user = FactoryGirl.create(:user_admin)
          role = FactoryGirl.create(:role)
          @user.roles= [role]

          sign_in @user
          allow(controller).to receive(:current_user) { @user }
          allow(controller).to receive(:authenticate_user!)

          disponibilite = double
          expect(Disponibilite).to receive(:find).with("1") { disponibilite }

          expect(disponibilite).to receive(:statut) { "canceled" }

          expect(controller).to receive(:date_heure_limit_answer).with(disponibilite)

          get :edit, id: "1"
        end
      end
    end
    it "invalid session" do
      get :edit, {id: 1}

      is_expected.to redirect_to(new_user_session_path)
    end
  end

  describe "POST create" do
    describe "valid session" do
      describe "with valid params" do
        describe "with user_remplacant" do
          before(:each) do
            @user = FactoryGirl.create(:user_admin)
            role = FactoryGirl.create(:role)
            @user.roles= [role]

            sign_in @user
            allow(controller).to receive(:current_user) { @user }
            allow(controller).to receive(:authenticate_user!)
          end

          it "when user remplacant founded" do
            disponibilite = double
            user = double
            date_heure_fin = "2016-01-30"
            date_heure_debut = "2016-01-01"
            disponibilite_param = {date_heure_debut: "2016-01-01", date_heure_fin:"2016-01-30"}
            demande = double("demande")
            mailer = double
            user_remplacant_id = double("user_remplacant_id")
            disponibilite_id = double("disponibilite_id")

            expect(Disponibilite).to receive(:new).with(disponibilite_param).and_return(disponibilite)

            expect(disponibilite).to receive(:date_heure_fin) {date_heure_fin}
            expect(disponibilite).to receive(:date_heure_debut) {date_heure_debut}

            expect(User).to receive(:find_by_next_user_remplacant_available).with(date_heure_debut, date_heure_fin, nil) {user}

            expect(disponibilite).to receive(:date_time_expired=).with(DateTime.current + 3.hours)

            expect(user).to receive(:nil?).twice {false}
            expect(disponibilite).to receive(:user_remplacant=).with(user)
            expect(disponibilite).to receive(:statut=).with("waiting")

            expect(disponibilite).to receive(:save) {true}

            expect(disponibilite).to receive(:user_remplacant) {user}

            expect(user).to receive(:id) {user_remplacant_id}
            expect(disponibilite).to receive(:id) {disponibilite_id}

            expect(Demande).to receive(:create!).with(user_id: user_remplacant_id, disponibilite_id: disponibilite_id, status: "waiting") {demande}

            expect(DisponibiliteMailer).to receive(:nouvelle_disponibilite_email).with(user, disponibilite) {mailer}
            expect(mailer).to receive(:deliver_later)

            expect(disponibilite).to receive(:id) {double}

            post :create, {:disponibilite => disponibilite_param}

            expect(flash[:notice]).to eq "L'absence a été créée avec succès."
          end

          it "when user remplacant not founded" do
            disponibilite = double
            user = double
            date_heure_fin = "2016-01-30"
            date_heure_debut = "2016-01-01"
            disponibilite_param = {date_heure_debut: "2016-01-01", date_heure_fin:"2016-01-30"}

            expect(Disponibilite).to receive(:new).with(disponibilite_param).and_return(disponibilite)

            expect(disponibilite).to receive(:date_heure_fin) {date_heure_fin}
            expect(disponibilite).to receive(:date_heure_debut) {date_heure_debut}

            expect(User).to receive(:find_by_next_user_remplacant_available).with(date_heure_debut, date_heure_fin, nil) {user}

            expect(disponibilite).to receive(:date_time_expired=).with(DateTime.current + 3.hours)

            expect(user).to receive(:nil?).twice {true}
            expect(disponibilite).to receive(:statut=).with("waiting")

            expect(disponibilite).to receive(:save) {true}

            expect(disponibilite).to receive(:id) {double}

            post :create, {:disponibilite => disponibilite_param}

            expect(flash[:notice]).to eq "L'absence a été créée avec succès."
          end

          it "when disponibilite not saved" do
            disponibilite = double
            user = double
            date_heure_fin = "2016-01-30"
            date_heure_debut = "2016-01-01"
            disponibilite_param = {date_heure_debut: "2016-01-01", date_heure_fin:"2016-01-30"}

            expect(Disponibilite).to receive(:new).with(disponibilite_param).and_return(disponibilite)

            expect(disponibilite).to receive(:date_heure_fin) {date_heure_fin}
            expect(disponibilite).to receive(:date_heure_debut) {date_heure_debut}

            expect(User).to receive(:find_by_next_user_remplacant_available).with(date_heure_debut, date_heure_fin, nil) {user}

            expect(disponibilite).to receive(:date_time_expired=).with(DateTime.current + 3.hours)

            expect(user).to receive(:nil?) {false}
            expect(disponibilite).to receive(:user_remplacant=).with(user)
            expect(disponibilite).to receive(:statut=).with("waiting")

            expect(disponibilite).to receive(:save) {false}

            expect(User).to receive(:where).with(:titre => 'permanent') {double}

            post :create, {:disponibilite => disponibilite_param}
          end
        end
      end
    end

    it "invalid session" do
      post :create, {:disponibilite => valid_attributes}

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "PUT update" do
    describe "valid session" do
      before(:each) do
        @user = FactoryGirl.create(:user_admin)
        role = FactoryGirl.create(:role)
        @user.roles= [role]

        sign_in @user
        allow(controller).to receive(:current_user) { @user }
        allow(controller).to receive(:authenticate_user!)
      end

      specify "success" do
        disponibilite = double
        disponibilite_param = {date_heure_debut: "2016-01-01", date_heure_fin:"2016-01-30"}

        expect(Disponibilite).to receive(:find).with("1") {disponibilite}

        expect(disponibilite).to receive(:update).with(disponibilite_param) {true}
        expect(disponibilite).to receive(:id) {1}
        put :update, {id: 1, disponibilite: disponibilite_param}

        expect(flash[:notice]).to eq "L'absence a été modifiée avec succès."
      end

      specify "not saved successfully" do
        disponibilite = double
        disponibilite_param = {date_heure_debut: "2016-01-01", date_heure_fin:"2016-01-30"}

        expect(Disponibilite).to receive(:find).with("1") {disponibilite}

        expect(disponibilite).to receive(:update).with(disponibilite_param) {false}

        expect(User).to receive(:where).with(:titre => 'permanent') {double}

        put :update, {id: 1, disponibilite: disponibilite_param}
      end
    end

    it "invalid session" do
      put :update, {:id => 1, :disponibilite => { "user_absent_id" => "1" }}

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "get cancel" do
    describe "valid session" do
      before(:each) do
        @user = FactoryGirl.create(:user_admin)
        role = FactoryGirl.create(:role)
        @user.roles= [role]

        sign_in @user
        allow(controller).to receive(:current_user) { @user }
        allow(controller).to receive(:authenticate_user!)
      end

      specify "success" do
        disponibilite = double

        expect(Disponibilite).to receive(:find).with("1") {disponibilite}

        expect(disponibilite).to receive(:statut=).with("canceled") {disponibilite}
        expect(disponibilite).to receive(:user_remplacant=).with(nil) {disponibilite}
        expect(disponibilite).to receive(:date_time_expired=).with(nil) {disponibilite}
        expect(disponibilite).to receive(:save) {true}

        expect(disponibilite).to receive(:id) {1}

        get :cancel, {id: 1}

        expect(response).to redirect_to(edit_disponibilite_path)
        expect(flash[:notice]).to eq "L'absence a été annulée avec succès."
      end

      specify "not saved successfully" do
        disponibilite = double

        expect(Disponibilite).to receive(:find).with("1") {disponibilite}

        expect(disponibilite).to receive(:statut=).with("canceled") {disponibilite}
        expect(disponibilite).to receive(:user_remplacant=).with(nil) {disponibilite}
        expect(disponibilite).to receive(:date_time_expired=).with(nil) {disponibilite}
        expect(disponibilite).to receive(:save) {false}

        get :cancel, {id: 1}

        expect(response).to render_template(:edit)
      end
    end

    it "invalid session" do
      get :cancel, {id: 1}

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "GET for_calendar" do
    describe "valid session" do
      before(:each) do
        @user = FactoryGirl.create(:user_admin)
        role = FactoryGirl.create(:role)
        @user.roles= [role]

        sign_in @user
        allow(controller).to receive(:current_user) { @user }
        allow(controller).to receive(:authenticate_user!)
      end

      it "assigns disponibilites as @events" do
        niveau = "maternelle"
        user_absent_nom = "Demers permanent, Nicolas"

        disponibilite = {id: 1, niveau_id:12, date_heure_debut: DateTime.now + 1.minute, date_heure_fin: DateTime.now + 1.hour,
                          statut: "available"}
        liste_dispo = [disponibilite]

        expect(controller).to receive(:get_disponibilites).with(Time.at(1417323600.to_i).to_date,Time.at(1420952400.to_i).to_date) {liste_dispo}

        expect(controller).to receive(:get_description_niveau).with(12) {niveau}
        expect(controller).to receive(:get_user_absent_nom_format).with(disponibilite) {user_absent_nom}

        ecole = double

        expect(disponibilite).to receive(:id) {1}
        expect(disponibilite).to receive(:date_heure_debut).exactly(6) {DateTime.now + 1.minute}
        expect(disponibilite).to receive(:date_heure_fin).exactly(6) {DateTime.now + 1.hour}
        expect(disponibilite).to receive(:statut).exactly(2) {"attente"}
        expect(disponibilite).to receive(:ecole) {ecole}
        expect(ecole).to receive(:nom) {"École test"}
        expect(disponibilite).to receive(:niveau_id) {12}

        get :for_calendar, {start: 1417323600, end: 1420952400}, format: 'json'

        expect(assigns(:events)).to eq([{:id=>1, :title=>disponibilite.date_heure_debut.strftime("%H:%M") + " - " + disponibilite.date_heure_fin.strftime("%H:%M"),
                                         :className=>"event-red", :start=>disponibilite.date_heure_debut.strftime("%Y/%m/%d"),
                                         :end=>disponibilite.date_heure_fin.strftime("%Y/%m/%d"),
                                         :title_msg=>disponibilite.date_heure_debut.strftime("%Y/%m/%d %l:%M %p") + " - " + disponibilite.date_heure_fin.strftime("%Y/%m/%d %l:%M %p"),
                                         :nom_ecole=>"École test",
                                         :nom_niveau=>"maternelle",
                                         :nom_user_absent=>"Demers permanent, Nicolas"}])
      end

      it "assigns disponibilites without @events" do
        liste_dispo = []

        expect(controller).to receive(:get_disponibilites).with(Time.at(1417323600.to_i).to_date,Time.at(1420952400.to_i).to_date) {liste_dispo}

        get :for_calendar, {start: 1417323600, end: 1420952400}, format: 'json'

        expect(assigns(:events)).to eq([])
      end
    end

    it "invalid session" do
      get :for_calendar, {start: 1417323600, end: 1420952400}, format: 'json'

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "GET accept_availability" do
    describe "valid session" do
      before(:each) do
        @user = FactoryGirl.create(:user_admin)
        role = FactoryGirl.create(:role)
        @user.roles= [role]

        sign_in @user
        allow(controller).to receive(:current_user) { @user }
        allow(controller).to receive(:authenticate_user!)
      end

      it "assign success" do
        disponibilite = double
        date_time_expired = double

        expect(Disponibilite).to receive(:find).with("1") { disponibilite }

        expect(disponibilite).to receive(:statut=).with("assigned") {disponibilite}

        expect(disponibilite).to receive(:date_time_expired) {date_time_expired}
        expect(controller).to receive(:is_time_expired?).with(date_time_expired) {false}

        expect(disponibilite).to receive(:save) { true }

        expect(disponibilite).to receive(:id) {"1"}

        get :accept_availability, {:id => "1"}

        expect(response).to redirect_to(edit_disponibilite_path)
        expect(flash[:notice]).to eq "L'absence a été acceptée avec succès."
      end

      it "assign not succed" do
        disponibilite = double
        date_time_expired = double

        expect(Disponibilite).to receive(:find).with("1") { disponibilite }

        expect(disponibilite).to receive(:statut=).with("assigned") {disponibilite}

        expect(disponibilite).to receive(:date_time_expired) {date_time_expired}
        expect(controller).to receive(:is_time_expired?).with(date_time_expired) {false}

        expect(disponibilite).to receive(:save) { false }

        expect(disponibilite).to receive(:id) {"1"}

        get :accept_availability, {:id => "1"}

        expect(response).to redirect_to(edit_disponibilite_path)
        #expect(flash[:warning]).to eq "Une erreur est survenue. L'absence n'a pu être accepté."
      end

      it "time to assign is expired" do
        disponibilite = double
        date_time_expired = double

        expect(Disponibilite).to receive(:find).with("1") { disponibilite }

        expect(disponibilite).to receive(:statut=).with("assigned") {disponibilite}

        expect(disponibilite).to receive(:date_time_expired) {date_time_expired}
        expect(controller).to receive(:is_time_expired?).with(date_time_expired) {true}

        expect(disponibilite).to receive(:id) {"1"}

        get :accept_availability, {:id => "1"}

        expect(response).to redirect_to(edit_disponibilite_path)
        #expect(flash[:warning]).to eq "Votre temps pour répondre est écoulé. Il n'est plus possible de l'accepter."
      end
    end
    it "invalid session" do
      get :accept_availability, {id: 1}

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "GET deny_availability" do
    describe "valid session" do
      before(:each) do
        @user = FactoryGirl.create(:user_admin)
        role = FactoryGirl.create(:role)
        @user.roles= [role]

        sign_in @user
        allow(controller).to receive(:current_user) { @user }
        allow(controller).to receive(:authenticate_user!)
      end

      it "assign refused success" do
        disponibilite = double
        date_time_expired = double
        date_heure_debut = double
        date_heure_fin = double
        user = double
        demande = double
        user_remplacant_id = double("user_remplacant_id")
        disponibilite_id = double("disponibilite_id")

        expect(Disponibilite).to receive(:find).with("1") { disponibilite }

        expect(disponibilite).to receive(:statut=).with("denied") {disponibilite}

        expect(disponibilite).to receive(:date_time_expired) {date_time_expired}
        expect(controller).to receive(:is_time_expired?).with(date_time_expired) {false}

        expect(disponibilite).to receive(:date_heure_fin) {date_heure_fin}
        expect(disponibilite).to receive(:date_heure_debut) {date_heure_debut}

        expect(disponibilite).to receive(:id) {11}

        expect(User).to receive(:find_by_next_user_remplacant_available).with(date_heure_debut, date_heure_fin, 11) {user}
        expect(user).to receive(:nil?) {false}
        expect(disponibilite).to receive(:user_remplacant=) {user}
        expect(disponibilite).to receive(:date_time_expired=) {DateTime.current + 3.hours}
        expect(disponibilite).to receive(:statut=).with("waiting") {disponibilite}

        expect(user).to receive(:id) {user_remplacant_id}
        expect(disponibilite).to receive(:id) {disponibilite_id}

        expect(Demande).to receive(:create!).with(user_id: user_remplacant_id, disponibilite_id: disponibilite_id, status: "waiting") {demande}

        expect(disponibilite).to receive(:save) { true }

        get :deny_availability, {:id => "1"}

        expect(response).to redirect_to(disponibilites_url)
        expect(flash[:notice]).to eq "L'absence a été refusée avec succès."
      end

      it "assign refused success but user_remplacant not find" do
        disponibilite = double
        date_time_expired = double
        date_heure_debut = double
        date_heure_fin = double
        user = double

        expect(Disponibilite).to receive(:find).with("1") { disponibilite }

        expect(disponibilite).to receive(:statut=).with("denied") {disponibilite}

        expect(disponibilite).to receive(:date_time_expired) {date_time_expired}
        expect(controller).to receive(:is_time_expired?).with(date_time_expired) {false}

        expect(disponibilite).to receive(:date_heure_fin) {date_heure_fin}
        expect(disponibilite).to receive(:date_heure_debut) {date_heure_debut}

        expect(disponibilite).to receive(:id) {11}

        expect(User).to receive(:find_by_next_user_remplacant_available).with(date_heure_debut, date_heure_fin, 11) {user}
        expect(user).to receive(:nil?) {true}
        expect(disponibilite).to receive(:user_remplacant=) {nil}
        expect(disponibilite).to receive(:date_time_expired=) {nil}

        expect(disponibilite).to receive(:save) { true }

        get :deny_availability, {:id => "1"}

        expect(response).to redirect_to(disponibilites_url)
        expect(flash[:notice]).to eq "L'absence a été refusée avec succès."
      end

      it "assign refused not succed" do
        disponibilite = double
        date_time_expired = double
        date_heure_debut = double
        date_heure_fin = double
        user = double
        demande = double
        user_remplacant_id = double("user_remplacant_id")
        disponibilite_id = double("disponibilite_id")

        expect(Disponibilite).to receive(:find).with("1") { disponibilite }

        expect(disponibilite).to receive(:statut=).with("denied") {disponibilite}

        expect(disponibilite).to receive(:date_time_expired) {date_time_expired}
        expect(controller).to receive(:is_time_expired?).with(date_time_expired) {false}

        expect(disponibilite).to receive(:date_heure_fin) {date_heure_fin}
        expect(disponibilite).to receive(:date_heure_debut) {date_heure_debut}

        expect(disponibilite).to receive(:id) {11}

        expect(User).to receive(:find_by_next_user_remplacant_available).with(date_heure_debut, date_heure_fin, 11) {user}
        expect(user).to receive(:nil?) {false}
        expect(disponibilite).to receive(:user_remplacant=) {user}
        expect(disponibilite).to receive(:date_time_expired=) {DateTime.current + 3.hours}
        expect(disponibilite).to receive(:statut=).with("waiting") {disponibilite}

        expect(user).to receive(:id) {user_remplacant_id}
        expect(disponibilite).to receive(:id) {disponibilite_id}

        expect(Demande).to receive(:create!).with(user_id: user_remplacant_id, disponibilite_id: disponibilite_id, status: "waiting") {demande}

        expect(disponibilite).to receive(:save) { false }

        expect(disponibilite).to receive(:id) {"1"}

        get :deny_availability, {:id => "1"}

        expect(response).to redirect_to(edit_disponibilite_path)
        #expect(flash[:warning]).to eq "Une erreur est survenue. L'absence n'a pu être refusée."
      end

      it "time to refuse is expired" do
        disponibilite = double
        date_time_expired = double

        expect(Disponibilite).to receive(:find).with("1") { disponibilite }

        expect(disponibilite).to receive(:statut=).with("denied") {disponibilite}

        expect(disponibilite).to receive(:date_time_expired) {date_time_expired}
        expect(controller).to receive(:is_time_expired?).with(date_time_expired) {true}

        expect(disponibilite).to receive(:id) {"1"}

        get :deny_availability, {:id => "1"}

        expect(response).to redirect_to(edit_disponibilite_path)
        #expect(flash[:warning]).to eq "Votre temps pour répondre est écoulé. Il n'est plus possible de la refuser."
      end
    end
    it "invalid session" do
      get :deny_availability, {id: 1}

      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
