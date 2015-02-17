class EcolesController < ApplicationController
  before_action :authenticate_utilisateur!
  before_action :set_ecole, only: [:show, :edit, :update, :destroy]

  def index
    @ecoles = Ecole.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ecoles }
    end
  end

  def show
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ecole }
    end
  end

  def new
    @ecole = Ecole.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ecole }
    end
  end

  def edit
  end

  def create
    @ecole = Ecole.new(ecole_params)
    respond_to do |format|
      if @ecole.save
        format.html { redirect_to @ecole, notice: t("ecole.messages.save_creation_succes") }
        format.json { render json: @ecole, status: :created, location: @ecole }
      else
        format.html { render action: "new" }
        format.json { render json: @ecole.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @ecole.update(ecole_params)
        format.html { redirect_to @ecole, notice: t("ecole.messages.save_modification_succes") }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ecole.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @ecole.destroy
    respond_to do |format|
      format.html { redirect_to ecoles_path }
      format.json { head :no_content }
    end
  end

  private
    def set_ecole
      @ecole = Ecole.find(params[:id])
    end

    def ecole_params
      params.require(:ecole).permit(:nom, :adresse, :numero_telephone)
    end
end
