class HomeController < ApplicationController
  include DisponibilitesConcern

  before_action :authenticate_user!

  def index
    @disponibilites_avenir = get_disponibilites_avenir_non_attribue
  end
end
