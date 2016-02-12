class EcolesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @ecoles = Ecole.all
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    if @ecole.save
      redirect_to @ecole, notice: t("ecole.messages.save_creation_succes")
    else
      render action: "new"
    end
  end

  def update
    if @ecole.update(ecole_params)
      redirect_to @ecole, notice: t("ecole.messages.save_modification_succes")
    else
      render action: "edit"
    end
  end

  def destroy
    @ecole.destroy
    redirect_to ecoles_path
  end

  private
    def ecole_params
      params.require(:ecole).permit(:nom, :adresse, :numero_telephone)
    end
end
