class HomeController < ApplicationController

  before_action :authenticate_utilisateur!

  def index
    @disponibilites_avenir = get_disponibilites_avenir_non_attribue
    @disponibilites = Disponibilite.all
  end
end
