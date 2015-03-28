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

describe UsersController do

  # This should return the minimal set of attributes required to create a valid
  # user. As you add validations to user, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "email" => "user@courriel.ca", "nom" => "Nom", "prenom" => "Prénom", "numero_telephone" => "444 444-4444", "titre" => "Permanent", "password" => "12345678" } }
  let(:valid_attributes_without_password) { { "email" => "user@courriel.ca", "nom" => "Nom", "prenom" => "Prénom", "numero_telephone" => "444 444-4444", "titre" => "Permanent" } }

  describe "GET index" do
    describe "valid session" do
      it "assigns all users as @users" do
        user = FactoryGirl.create(:user_admin)
        role = FactoryGirl.create(:role)
        user.roles= [role]

        sign_in user

        #User.stub_chain(:where, :first).and_return(user)

        allow(Disponibilite).to receive(:where).with("(statut = 'waiting' or statut = 'available') and date_heure_debut between :date_debut and :date_fin",{date_debut: Date.current, :date_fin=> Date.current + 2.months}) {nil}

        #user_permanent = FactoryGirl.create(:user_permanent2)

        #allow(User).to receive(:all) {[user_permanent]}
        #expect(User).to receive(:all).and_return([user_permanent])

        get :index, {}
        is_expected.to render_template(:index)
        #assigns(:Users).should eq([user_permanent])
      end
    end
    it "invalid session" do
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})

      get :index, {}

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "GET show" do
    describe "valid session" do
      it "assigns the requested user as @user" do
        user = FactoryGirl.create(:user_admin)
        role = FactoryGirl.create(:role)
        user.roles= [role]

        sign_in user

        User.stub_chain(:where, :first).and_return(user)

        allow(Disponibilite).to receive(:where).with("(statut = 'waiting' or statut = 'available') and date_heure_debut between :date_debut and :date_fin",{date_debut: Date.current, :date_fin=> Date.current + 2.months}) {nil}

        allow(User).to receive(:find).with(user.id.to_s) { user }

        user_permanent = FactoryGirl.create(:user_permanent2)

        allow(User).to receive(:all) {[user_permanent]}

        get :show, {:id => user}
        expect(assigns(:user)).to eq(user)
      end
    end
    it "invalid session" do
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})

      user = create(:user_permanent)
      get :show, {:id => user}

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "GET new" do
    describe "valid session" do
      it "assigns a new user as @user" do
        user = FactoryGirl.create(:user_admin)
        role = FactoryGirl.create(:role)
        user.roles= [role]

        sign_in user

        User.stub_chain(:where, :first).and_return(user)

        allow(Disponibilite).to receive(:where).with("(statut = 'waiting' or statut = 'available') and date_heure_debut between :date_debut and :date_fin",{date_debut: Date.current, :date_fin=> Date.current + 2.months}) {nil}

        get :new, {}
        expect(assigns(:user)).to be_a_new(User)
      end
    end
    it "invalid session" do
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})

      get :new, {}

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "GET edit" do
    describe "valid session" do
      it "assigns the requested user as @user" do
        user = FactoryGirl.create(:user_admin)
        role = FactoryGirl.create(:role)
        user.roles= [role]

        sign_in user

        User.stub_chain(:where, :first).and_return(user)

        allow(Disponibilite).to receive(:where).with("(statut = 'waiting' or statut = 'available') and date_heure_debut between :date_debut and :date_fin",{date_debut: Date.current, :date_fin=> Date.current + 2.months}) {nil}

        allow(User).to receive(:find).with(user.id.to_s) { user }

        get :edit, {:id => user.to_param}
        expect(assigns(:user)).to eq(user)
      end
    end
    it "invalid session" do
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
      user = create(:user_permanent)

      get :edit, {:id => user.to_param}

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "POST create" do
    describe "valid session" do
      before(:each) do
        @user = FactoryGirl.create(:user_admin)
        role = FactoryGirl.create(:role)
        @user.roles= [role]

        sign_in @user
      end

      describe "with valid params" do

        it "assigns a newly created user as @user" do
          user_permanent = create(:user_permanent2)
          allow(User).to receive(:new) {user_permanent}

          allow(user_permanent).to receive(:save) {true}

          post :create, {:user => valid_attributes}
          expect(assigns(:user)).to be_a(User)
        end

        it "assigns a newly created user as @user without password" do
          user_permanent = create(:user_permanent2)
          user_permanent.password= nil

          allow(User).to receive(:new) {user_permanent}

          allow(user_permanent).to receive(:save) {true}

          post :create, {:user => valid_attributes_without_password}
          expect(assigns(:user)).to be_a(User)
        end

        #it "redirects to the created user" do
        #  user = create(:user_permanent)
        #  user.stub(:new).and_return(user)

        #  user.stub(:save).and_return(true)

        #  post :create, {:user => valid_attributes}
        #  response.should redirect_to(user.last)
        #end
      end

      describe "with invalid params" do
        before(:each) do
          allow(Disponibilite).to receive(:where).with("(statut = 'waiting' or statut = 'available') and date_heure_debut between :date_debut and :date_fin",{date_debut: Date.current, :date_fin=> Date.current + 2.months}) {nil}
        end

        it "assigns a newly created but unsaved user as @user" do
          # Trigger the behavior that occurs when invalid params are submitted
          User.any_instance.stub(:save).and_return(false)
          post :create, {:user => valid_attributes}
          expect(assigns(:user)).to be_a_new(User)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          User.any_instance.stub(:save).and_return(false)
          post :create, {:user => valid_attributes}
          expect(response).to render_template("new")
        end
      end
    end
    it "invalid session" do
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})

      post :create, {:user => valid_attributes}

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
      end

      describe "with valid params" do
        before(:each) do
          @user_permanent = create(:user_permanent2)
          allow(User).to receive(:find).with(@user_permanent.id.to_s) {@user_permanent}
        end

        it "updates the requested user" do
          # Assuming there are no other users in the database, this
          # specifies that the user created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          expect_any_instance_of(User).to receive(:update).with( valid_attributes).and_return(true)
          put :update, {:id => @user_permanent.to_param, :user => valid_attributes}
        end

        it "updates the requested user without password" do
          @user.password= nil
          # Assuming there are no other users in the database, this
          # specifies that the user created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          expect_any_instance_of(User).to receive(:update).with( valid_attributes_without_password).and_return(true)
          put :update, {:id => @user_permanent.to_param, :user => valid_attributes_without_password}

        end

        it "assigns the requested user as @user" do
          put :update, {:id => @user_permanent.to_param, :user => valid_attributes}
          expect(assigns(:user)).to eq(@user_permanent)
        end

        it "redirects to the user" do
          put :update, {:id => @user_permanent.to_param, :user => valid_attributes}
          expect(response).to redirect_to(@user_permanent)
        end
      end

      describe "with invalid params" do
        before(:each) do
          allow(Disponibilite).to receive(:where).with("(statut = 'waiting' or statut = 'available') and date_heure_debut between :date_debut and :date_fin",{date_debut: Date.current, :date_fin=> Date.current + 2.months}) {nil}

          @user_permanent = create(:user_permanent2)
          allow(User).to receive(:find).with(@user_permanent.id.to_s) {@user_permanent}
        end

        it "assigns the user as @user" do
          # Trigger the behavior that occurs when invalid params are submitted
          User.any_instance.stub(:save).and_return(false)
          put :update, {:id => @user_permanent.to_param, :user => valid_attributes}
          expect(assigns(:user)).to eq(@user_permanent)
        end

        it "re-renders the 'edit' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          User.any_instance.stub(:save).and_return(false)
          put :update, {:id => @user_permanent.to_param, :user => valid_attributes}
          expect(response).to render_template("edit")
        end
      end
    end
    it "invalid session" do
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
      @user = create(:user_permanent)

      put :update, {:id => @user.to_param, :user => valid_attributes}

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "DELETE destroy" do
    describe "valid session" do
      before(:each) do
        @user = FactoryGirl.create(:user_admin)
        role = FactoryGirl.create(:role)
        @user.roles= [role]

        sign_in @user
      end

      #it "destroys the requested user" do
      #  expect {
      #    delete :destroy, {:id => @user.to_param}
      #  }.to change(user, :count).by(-1)
      #end

      it "redirects to the users list" do
        @user_permanent = create(:user_permanent2)
        allow(User).to receive(:find).with(@user_permanent.id.to_s) {@user_permanent}

        allow(Disponibilite).to receive(:where).with("(statut = 'waiting' or statut = 'available') and date_heure_debut between :date_debut and :date_fin",{date_debut: Date.current, :date_fin=> Date.current + 2.months}) {nil}

        delete :destroy, {:id => @user_permanent.to_param}
        expect(response).to redirect_to(users_url)
      end
    end
    it "invalid session" do
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
      @user_permanent = create(:user_permanent2)

      allow(Disponibilite).to receive(:where).with("(statut = 'waiting' or statut = 'available') and date_heure_debut between :date_debut and :date_fin",{date_debut: Date.current, :date_fin=> Date.current + 2.months}) {nil}

      delete :destroy, {:id => @user_permanent.to_param}

      expect(response).to redirect_to(new_user_session_path)
    end
  end
end