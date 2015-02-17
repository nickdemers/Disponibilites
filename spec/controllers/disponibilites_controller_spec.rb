require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe DisponibilitesController do

  # This should return the minimal set of attributes required to create a valid
  # Disponibilite. As you add validations to Disponibilite, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "endroit_id" => "11", "niveau_id" => "12", "date_heure_debut" => DateTime.now + 1.minute, "date_heure_fin" => DateTime.now + 1.hour, "statut" => "attente", "utilisateur_absent_id" => "11", "utilisateur_remplacant_id" => "12"} }
=begin
  describe "GET index" do
    describe "valid session" do
      it "assigns all disponibilites as @disponibilites" do
        role = Role.create({nom: 'admin'})
        utilisateur = Utilisateur.create({prenom: 'Nicolas', nom: 'Demers', message_texte_permis: false, niveau: 3, email: 'test@test.ca',
                                          numero_cellulaire: '418 999-8888', numero_telephone: '418 777-5555', titre: 'Permanent', password: '12345678', roles: [role]})
        sign_in(utilisateur)

        disponibilite = create(:disponibilite_disponible)

        allow(Disponibilite).to receive(:where).with("(statut = 'attente' or statut = 'disponible') and date_heure_debut between :date_debut and :date_fin",{date_debut: Date.current, :date_fin=> Date.current + 2.months}){nil}
        allow(Disponibilite).to receive(:all) {[disponibilite]}

        get :index, {}
        assigns(:disponibilites).should eq([disponibilite])
      end
    end

    it "invalid session" do
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :utilisateur})

      get :index, {}

      response.should redirect_to(new_utilisateur_session_path)
    end
  end

  describe "GET show" do
    describe "valid session" do
      describe "assigns the requested disponibilite as @disponibilite" do
        before(:each) do
          role = Role.create({nom: 'admin'})
          utilisateur = Utilisateur.create({prenom: 'Nicolas', nom: 'Demers', message_texte_permis: false, niveau: 3, email: 'test@test.ca',
                                            numero_cellulaire: '418 999-8888', numero_telephone: '418 777-5555', titre: 'Permanent', password: '12345678', roles: [role]})
          sign_in(utilisateur)

          allow(Disponibilite).to receive(:where).with("(statut = 'attente' or statut = 'disponible') and date_heure_debut between :date_debut and :date_fin",{date_debut: Date.current, :date_fin=> Date.current + 2.months}) {nil}
        end

        it "with utilisateur_remplacant" do
          disponibilite = create(:disponibilite_attribue)

          allow(Disponibilite).to receive(:find).with(disponibilite.id.to_s) { disponibilite }

          utilisateur_absent = create(:utilisateur_permanent2)
          allow(Utilisateur).to receive(:find).with(disponibilite.utilisateur_absent) { utilisateur_absent }

          utilisateur_remplacant = create(:utilisateur_remplacant2)
          allow(Utilisateur).to receive(:find).with(disponibilite.utilisateur_remplacant) { utilisateur_remplacant }

          get :show, {:id => disponibilite}
          assigns(:disponibilite).should eq(disponibilite)
        end
        it "without utilisateur_remplacant" do
          disponibilite = create(:disponibilite_disponible)

          allow(Disponibilite).to receive(:find).with(disponibilite.id.to_s) { disponibilite }

          utilisateur_absent = create(:utilisateur_permanent2)
          allow(Utilisateur).to receive(:find).with(disponibilite.utilisateur_absent) { utilisateur_absent }

          get :show, {:id => disponibilite}
          assigns(:disponibilite).should eq(disponibilite)
        end
      end
    end
    it "invalid session" do
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :utilisateur})
      disponibilite = create(:disponibilite_disponible)

      get :show, {:id => disponibilite}

      response.should redirect_to(new_utilisateur_session_path)
    end
  end
=end
  describe "GET new" do
    describe "valid session" do
=begin
      before(:each) do
        role = Role.create({nom: 'admin'})
        utilisateur = Utilisateur.create({prenom: 'Nicolas', nom: 'Demers', message_texte_permis: false, niveau: 3, email: 'test@test.ca',
                                          numero_cellulaire: '418 999-8888', numero_telephone: '418 777-5555', titre: 'Permanent', password: '12345678', roles: [role]})
        sign_in(utilisateur)

        allow(Disponibilite).to receive(:where).with("(statut = 'attente' or statut = 'disponible') and date_heure_debut between :date_debut and :date_fin",{date_debut: Date.current, :date_fin=> Date.current + 2.months}) { nil }
      end

      it "assigns a new disponibilite as @disponibilite" do
        utilisateur_absent = create(:utilisateur_permanent)
        allow(Utilisateur).to receive(:find).with("titre = 'permanent'") { utilisateur_absent }

        get :new, {}
        assigns(:disponibilite).should be_a_new(Disponibilite)
      end
=end
      it "redirect to index, no utilisateur_absent available" do
        utilisateur = FactoryGirl.create(:utilisateur_is_admin)

        #role = Role.create({nom: 'admin'})
        #utilisateur = Utilisateur.create({prenom: 'Nicolas', nom: 'Demers', message_texte_permis: false, niveau: 3, email: 'test@test.ca',
        #                                  numero_cellulaire: '418 999-8888', numero_telephone: '418 777-5555', titre: 'Permanent', password: '12345678', roles: [role]})
        sign_in utilisateur

        #disponibilite = create(:disponibilite_disponible)

        #allow(Disponibilite).to receive(:where).with("(statut = 'attente' or statut = 'disponible') and date_heure_debut between :date_debut and :date_fin",{date_debut: Date.current, :date_fin=> Date.current + 2.months}){nil}
        #allow(Utilisateur).to receive(:where).with({"id" => utilisateur.id}) { utilisateur }
        #allow(Utilisateur).to receive(:where).with("email = 'test@test.ca'") { utilisateur }

        #@utilisateur_absent = nil
        #allow(Utilisateur).to receive(:find).with(:titre => "permanent") { nil }
        Utilisateur.stub_chain(:where).and_return(nil)

        get :new, {}
        response.should redirect_to(disponibilites_url)
      end
    end
=begin
    it "invalid session" do
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :utilisateur})

      get :new, {}

      response.should redirect_to(new_utilisateur_session_path)
    end
=end
  end
=begin
  describe "GET edit" do
    describe "valid session" do
      before(:each) do
        role = Role.create({nom: 'admin'})
        utilisateur = Utilisateur.create({prenom: 'Nicolas', nom: 'Demers', message_texte_permis: false, niveau: 3, email: 'test@test.ca',
                                          numero_cellulaire: '418 999-8888', numero_telephone: '418 777-5555', titre: 'Permanent', password: '12345678', roles: [role]})
        sign_in(utilisateur)

        allow(Disponibilite).to receive(:where).with("(statut = 'attente' or statut = 'disponible') and date_heure_debut between :date_debut and :date_fin",{date_debut: Date.current, :date_fin=> Date.current + 2.months}) { nil }
      end

      it "assigns the requested disponibilite as @disponibilite with utilisateur_remplacant" do
        disponibilite = create(:disponibilite_attribue)

        allow(Disponibilite).to receive(:find).with(disponibilite.id.to_s) { disponibilite }

        utilisateur_remplacant = build(:utilisateur_remplacant)
        utilisateur_permanent = build(:utilisateur_permanent)

        allow(Utilisateur).to receive(:find).with("titre = 'permanent'") { utilisateur_permanent }

        allow(Utilisateur).to receive(:find).with(disponibilite.utilisateur_remplacant) { utilisateur_remplacant }

        get :edit, {:id => disponibilite.to_param}
        assigns(:disponibilite).should eq(disponibilite)

        disponibilite.utilisateur_remplacant.should eq(utilisateur_remplacant)
      end

      it "assigns the requested disponibilite as @disponibilite without utilisateur_remplacant" do
        disponibilite = create(:disponibilite_disponible)

        allow(Disponibilite).to receive(:find).with(disponibilite.id.to_s) { disponibilite }

        utilisateur_permanent = build(:utilisateur_permanent)

        allow(Utilisateur).to receive(:find).with("titre = 'permanent'") { utilisateur_permanent }

        get :edit, {:id => disponibilite.to_param}
        assigns(:disponibilite).should eq(disponibilite)

        disponibilite.utilisateur_remplacant.should be_nil
      end
    end
    it "invalid session" do
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :utilisateur})
      disponibilite = create(:disponibilite_disponible)

      get :edit, {:id => disponibilite.to_param}

      response.should redirect_to(new_utilisateur_session_path)
    end
  end

  describe "POST create" do
    describe "valid session" do
      before(:each) do
        role = Role.create({nom: 'admin'})
        utilisateur = Utilisateur.create({prenom: 'Nicolas', nom: 'Demers', message_texte_permis: false, niveau: 3, email: 'test@test.ca',
                                          numero_cellulaire: '418 999-8888', numero_telephone: '418 777-5555', titre: 'Permanent', password: '12345678', roles: [role]})
        sign_in(utilisateur)
      end
      describe "with valid params" do
        describe "with utilisateur_remplacant" do


          #it "creates a new Disponibilite" do
          #  disponibilite = build(:disponibilite_attribue)

          #  Disponibilite.stub(:new).and_return(disponibilite)

          #  expect {
          #    post :create, {disponibilite: {"endroit_id" => "11", "niveau_id" => "12", "date_heure_debut" => DateTime.now + 1.minute, "date_heure_fin" => DateTime.now + 1.hour, "statut" => disponibilite.statut, "utilisateur_absent_id" => @utilisateur_absent.id, "utilisateur_remplacant_id" => @utilisateur_remplacant.id}}, valid_session
          #  }.to change(Disponibilite, :count).by(1)
          #end

          it "assigns a newly created disponibilite as @disponibilite" do
            @utilisateur_absent = build_stubbed(:utilisateur_permanent)
            #Utilisateur.stub_chain(:where, :all).and_return(@utilisateur_absent)
            allow(Utilisateur).to receive(:find) { @utilisateur_absent }

            @utilisateur_remplacant = build_stubbed(:utilisateur_remplacant)
            Utilisateur.stub_chain(:order, :joins, :find, :first).and_return(@utilisateur_remplacant)

            disponibilite = build(:disponibilite_attribue)

            allow(Disponibilite).to receive(:new) { disponibilite }

            allow(disponibilite).to receive(:save) { true }

            post :create, {:disponibilite => valid_attributes}
            assigns(:disponibilite).should be_a(Disponibilite)
            #assigns(:disponibilite).should be_persisted

            disponibilite.utilisateur_remplacant.should eq(@utilisateur_remplacant)
            disponibilite.statut.should eq("attente")
          end

          #it "redirects to the created disponibilite" do
          #  disponibilite = build(:disponibilite_attribue)

          #  Disponibilite.stub(:new).and_return(disponibilite)

          #  disponibilite.stub(:save).and_return(true)

          #  post :create, {disponibilite: {"endroit_id" => "11", "niveau_id" => "12", "date_heure_debut" => DateTime.now + 1.minute, "date_heure_fin" => DateTime.now + 1.hour, "statut" => "attente", "utilisateur_absent_id" => "11", "utilisateur_remplacant_id" => @utilisateur_remplacant.id}}, valid_session
          #  response.should redirect_to(Disponibilite.last)
          #end
        end

        describe "without utilisateur_remplacant" do

          #it "creates a new Disponibilite" do
          #  expect {
          #    post :create, {disponibilite: {"endroit_id" => "11", "niveau_id" => "12", "date_heure_debut" => DateTime.now + 1.minute, "date_heure_fin" => DateTime.now + 1.hour, "statut" => "disponible", "utilisateur_absent_id" => @utilisateur_absent.id, "utilisateur_remplacant_id" => nil}}, valid_session
          #  }.to change(Disponibilite, :count).by(1)
          #end

          it "assigns a newly created disponibilite as @disponibilite" do
            @utilisateur_absent = build_stubbed(:utilisateur_permanent)
            allow(Utilisateur).to receive(:find) {@utilisateur_absent}

            @utilisateur_remplacant = build_stubbed(:utilisateur_remplacant)
            Utilisateur.stub_chain(:order, :joins, :find, :first).and_return(nil)

            disponibilite = build(:disponibilite_disponible)

            allow(Disponibilite).to receive(:new) { disponibilite }

            allow(disponibilite).to receive(:save) { true }

            post :create, {:disponibilite => valid_attributes}
            assigns(:disponibilite).should be_a(Disponibilite)
            #assigns(:disponibilite).should be_persisted

            disponibilite.utilisateur_remplacant.should be_nil
            disponibilite.statut.should eq("disponible")
          end

          #it "redirects to the created disponibilite" do
          #  post :create, {disponibilite: {"endroit_id" => "11", "niveau_id" => "12", "date_heure_debut" => DateTime.now + 1.minute, "date_heure_fin" => DateTime.now + 1.hour, "statut" => "disponible", "utilisateur_absent_id" => @utilisateur_absent.id, "utilisateur_remplacant_id" => nil}}, valid_session
          #  response.should redirect_to(Disponibilite.last)
          #end
        end
      end

      describe "with invalid params" do
        before(:each) do
          allow(Disponibilite).to receive(:where).with("(statut = 'attente' or statut = 'disponible') and date_heure_debut between :date_debut and :date_fin",{date_debut: Date.current, :date_fin=> Date.current + 2.months}) { nil }

          @utilisateur_absent = build_stubbed(:utilisateur_permanent)
          Utilisateur.stub_chain(:find).and_return(@utilisateur_absent)

          @utilisateur_remplacant = build_stubbed(:utilisateur_remplacant)
          Utilisateur.stub_chain(:order, :joins, :find, :first).and_return(@utilisateur_remplacant)

          allow(Disponibilite).to receive(:save) { false }
        end

        it "assigns a newly created but unsaved disponibilite as @disponibilite" do
          # Trigger the behavior that occurs when invalid params are submitted
          post :create, {:disponibilite => { "utilisateur_absent_id" => "invalid value" }}
          assigns(:disponibilite).should be_a_new(Disponibilite)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          post :create, {:disponibilite => { "utilisateur_absent_id" => "invalid value" }}
          response.should render_template("new")
        end
      end
    end

    it "invalid session" do
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :utilisateur})

      post :create, {:disponibilite => valid_attributes}

      response.should redirect_to(new_utilisateur_session_path)
    end
  end

  describe "PUT update" do
    describe "valid session" do
      before(:each) do
        role = Role.create({nom: 'admin'})
        utilisateur = Utilisateur.create({prenom: 'Nicolas', nom: 'Demers', message_texte_permis: false, niveau: 3, email: 'test@test.ca',
                                          numero_cellulaire: '418 999-8888', numero_telephone: '418 777-5555', titre: 'Permanent', password: '12345678', roles: [role]})
        sign_in(utilisateur)
      end

      describe "with valid params" do
        before (:each) do
          @disponibilite = create(:disponibilite_disponible)

          allow(Disponibilite).to receive(:find).with(@disponibilite.id.to_s) { @disponibilite }
          allow(@disponibilite).to receive(:update) { true }
        end

        it "updates the requested disponibilite" do
          put :update, {:id => @disponibilite.to_param, :disponibilite => { "utilisateur_absent_id" => "1" }}
        end

        it "assigns the requested disponibilite as @disponibilite" do
          put :update, {:id => @disponibilite.to_param, :disponibilite => valid_attributes}
          assigns(:disponibilite).should eq(@disponibilite)
        end

        it "redirects to the disponibilite" do
          put :update, {:id => @disponibilite.to_param, :disponibilite => valid_attributes}
          response.should redirect_to(@disponibilite)
        end
      end

      describe "with invalid params" do
        before(:each) do
          allow(Disponibilite).to receive(:where).with("(statut = 'attente' or statut = 'disponible') and date_heure_debut between :date_debut and :date_fin",{date_debut: Date.current, :date_fin=> Date.current + 2.months}) { nil }

          @disponibilite = create(:disponibilite_disponible)

          allow(Disponibilite).to receive(:find).with(@disponibilite.id.to_s) { @disponibilite }

          allow(Disponibilite).to receive(:update) { false }

          @utilisateur_absent = build_stubbed(:utilisateur_permanent)
          allow(Utilisateur).to receive(:find) { @utilisateur_absent }
          #Utilisateur.stub_chain(:where,:all).and_return(@utilisateur_absent)
        end

        it "assigns the disponibilite as @disponibilite" do
          # Trigger the behavior that occurs when invalid params are submitted
          put :update, {:id => @disponibilite.to_param, :disponibilite => { "utilisateur_absent_id" => "invalid value" }}
          assigns(:disponibilite).should eq(@disponibilite)
        end
      end
    end
    it "invalid session" do
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :utilisateur})
      @disponibilite = create(:disponibilite_disponible)

      put :update, {:id => @disponibilite.to_param, :disponibilite => { "utilisateur_absent_id" => "1" }}

      response.should redirect_to(new_utilisateur_session_path)
    end
  end

  describe "DELETE destroy" do
    describe "valid session" do
      before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:utilisateur]
        utilisateur_session = double('utilisateur')
        allow(request.env['warden']).to receive(:authenticate!) { utilisateur_session }
      end

      it "redirects to the disponibilites list" do
        disponibilite = create(:disponibilite_disponible)

        allow(Disponibilite).to receive(:find).with(disponibilite.id.to_s) { disponibilite }
        allow(disponibilite).to receive(:destroy)

        delete :destroy, {:id => disponibilite.to_param}
        response.should redirect_to(disponibilites_url)
      end
    end

    it "invalid session" do
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :utilisateur})
      disponibilite = create(:disponibilite_disponible)

      delete :destroy, {:id => disponibilite.to_param}

      response.should redirect_to(new_utilisateur_session_path)
    end
  end

  describe "GET for_calendar" do
    describe "valid session" do
      before(:each) do
        role = Role.create({nom: 'admin'})
        utilisateur = Utilisateur.create({prenom: 'Nicolas', nom: 'Demers', message_texte_permis: false, niveau: 3, email: 'test@test.ca',
                                          numero_cellulaire: '418 999-8888', numero_telephone: '418 777-5555', titre: 'Permanent', password: '12345678', roles: [role]})
        sign_in(utilisateur)
      end

      it "assigns disponibilites as @events" do
        disponibilite = [create(:disponibilite_disponible)]

        allow(Disponibilite).to receive(:where) { disponibilite }

        get :for_calendar, {start: 1417323600, end: 1420952400}, format: 'json'
        assigns(:events).should eq([{:id=>disponibilite[0].id, :title=>disponibilite[0].date_heure_debut.strftime("%H:%M") + " - " + disponibilite[0].date_heure_fin.strftime("%H:%M"), :className=>"event-red", :start=>disponibilite[0].date_heure_debut.strftime("%Y/%m/%d"), :end=>disponibilite[0].date_heure_fin.strftime("%Y/%m/%d"), :url=>disponibilite_path(disponibilite[0])}])
      end

      it "assigns disponibilites without @events" do
        allow(Disponibilite).to receive(:where) { [] }

        get :for_calendar, {start: 1417323600, end: 1420952400}, format: 'json'
        assigns(:events).should eq([])
      end
    end
    it "invalid session" do
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :utilisateur})

      get :for_calendar, {start: 1417323600, end: 1420952400}, format: 'json'

      response.should redirect_to(new_utilisateur_session_path)
    end
  end
=end
end
