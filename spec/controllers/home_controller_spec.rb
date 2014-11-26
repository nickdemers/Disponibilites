#encoding=utf-8
require 'spec_helper'

describe HomeController do
  #routes { HomeController::Engine.routes }
  describe "Menu avec des disponibilités" do
    before(:each) do
      disponibilite_dispo = FactoryGirl.create(:disponibilite_disponible)
      Disponibilite.stub_chain(:where).and_return(disponibilite_dispo)
    end

    it "utilisateur non connecté, rediriger vers la page de loggin" do
      #routes { HomeController::Engine.routes }
      get 'index'

      #response.should redirect_to "/auth/google_oauth2"
    end

    it "utilisateur connecté, afficher le contenu" do
      #session = new Session

      #routes { HomeController::Engine.routes }
      get 'index'

      #response.should redirect_to "/auth/google_oauth2"
    end
  end
  describe "Menu sans disponibilité" do
    before(:each) do
      Disponibilite.stub_chain(:where).and_return(nil)
    end

    it "utilisateur non connecté, rediriger vers la page de loggin" do
      #routes { HomeController::Engine.routes }
      get 'index'

      #response.should redirect_to "/auth/google_oauth2"
    end

    it "utilisateur connecté, afficher le contenu" do
      #session = new Session

      #routes { HomeController::Engine.routes }
      get 'index'

      #response.should redirect_to "/auth/google_oauth2"
    end
  end
end