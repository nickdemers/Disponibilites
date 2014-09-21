#encoding=utf-8
require 'spec_helper'

describe HomeController do
  #routes { HomeController::Engine.routes }

  it "utilisateur non connecté, rediriger vers la page de loggin" do

    #routes { HomeController::Engine.routes }
    get 'index'

    response.should redirect_to "/auth/google_oauth2"

  end

  it "utilisateur connecté, afficher le contenu" do

    #session = new Session

    #routes { HomeController::Engine.routes }
    get 'index'

    response.should redirect_to "/auth/google_oauth2"

  end
end