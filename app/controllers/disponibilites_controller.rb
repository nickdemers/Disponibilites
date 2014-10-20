class DisponibilitesController < ApplicationController
  before_action :set_disponibilite, only: [:show, :edit, :update, :destroy]

  # GET /disponibilites
  # GET /disponibilites.json
  def index
    @disponibilites = Disponibilite.all
  end

  # GET /disponibilites/1
  # GET /disponibilites/1.json
  def show
  end

  # GET /disponibilites/new
  def new
    @utilisateur_absent = Utilisateur.where("titre = 'permanent'").all
    @disponibilite = Disponibilite.new
    if @utilisateur_absent.nil?
      respond_to do |format|
        format.html { redirect_to disponibilites_url, alert: "Aucun utilisateur absent disponible." }
        format.json { head :no_content }
      end
    end
  end

  # GET /disponibilites/1/edit
  def edit
    @utilisateur_absent = Utilisateur.where("titre = 'permanent'").all
  end

  # POST /disponibilites
  # POST /disponibilites.json
  def create
    @utilisateur_absent = Utilisateur.where("titre = 'permanent'").all

    @disponibilite = Disponibilite.new(disponibilite_params)

    @utilisateur_remplacant = Utilisateur.order("id").joins(:disponibilites_remplacant).where(["titre = 'remplacant' and ((? < disponibilites.date_heure_debut) or (? > disponibilites.date_heure_fin))", @disponibilite.date_heure_fin, @disponibilite.date_heure_debut]).first

    @disponibilite.utilisateur_remplacant= @utilisateur_remplacant

    if !@utilisateur_remplacant.nil?
      @disponibilite.statut= "attente"
    end

    respond_to do |format|
      if @disponibilite.save
        format.html { redirect_to @disponibilite, notice: 'Disponibilite was successfully created.' }
        format.json { render action: 'show', status: :created, location: @disponibilite }
      else
        format.html { render action: 'new' }
        format.json { render json: @disponibilite.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /disponibilites/1
  # PATCH/PUT /disponibilites/1.json
  def update
    respond_to do |format|
      if @disponibilite.update(disponibilite_params)
        format.html { redirect_to @disponibilite, notice: 'Disponibilite was successfully updated.' }
        format.json { head :no_content }
      else
        @utilisateur_absent = Utilisateur.where("titre = 'permanent'").all
        format.html { render action: 'edit' }
        format.json { render json: @disponibilite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /disponibilites/1
  # DELETE /disponibilites/1.json
  def destroy
    @disponibilite.destroy
    respond_to do |format|
      format.html { redirect_to disponibilites_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_disponibilite
      @disponibilite = Disponibilite.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def disponibilite_params
      params.require(:disponibilite).permit(:utilisateur_absent_id, :utilisateur_remplacant_id, :endroit_id, :niveau_id, :date_heure_debut, :date_heure_fin, :surveillance, :specialite, :notes, :statut, :created_at, :updated_at)
    end
end
