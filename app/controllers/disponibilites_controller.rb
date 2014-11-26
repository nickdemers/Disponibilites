class DisponibilitesController < ApplicationController
  before_action :set_disponibilite, only: [:show, :edit, :update, :destroy]
  before_action :set_disponibilites_avenir, only: [:index, :show, :new, :edit]

  # GET /disponibilites
  def index
    @disponibilites = Disponibilite.all
  end

  # GET /disponibilites/1
  def show
    @utilisateur_absent = Utilisateur.find(@disponibilite.utilisateur_absent)

    if !@disponibilite.utilisateur_remplacant.nil?
      @utilisateur_remplacant = Utilisateur.find(@disponibilite.utilisateur_remplacant)
    end
  end

  # GET /disponibilites/new
  def new
    @utilisateur_absent = Utilisateur.where("titre = 'permanent'").all

    if !@utilisateur_absent.nil?
      @disponibilite = Disponibilite.new

    else
      respond_to do |format|
        format.html { redirect_to disponibilites_url, alert: "Aucun utilisateur absent disponible." }
        format.json { head :no_content }
      end
    end
  end

  # GET /disponibilites/1/edit
  def edit
    @utilisateur_absent = Utilisateur.where("titre = 'permanent'").all

    if !@disponibilite.utilisateur_remplacant.nil?
      @utilisateur_remplacant = Utilisateur.find(@disponibilite.utilisateur_remplacant)
    end
  end

  # POST /disponibilites
  def create
    @disponibilite = Disponibilite.new(disponibilite_params)

    @utilisateur_absent = Utilisateur.where("titre = 'permanent'").all

    @utilisateur_remplacant = Utilisateur.order("id").joins(:disponibilites_remplacant).where(["titre = 'remplacant' and ((? < disponibilites.date_heure_debut) or (? > disponibilites.date_heure_fin))", @disponibilite.date_heure_fin, @disponibilite.date_heure_debut]).first

    if !@utilisateur_remplacant.nil?
      @disponibilite.utilisateur_remplacant= @utilisateur_remplacant
      @disponibilite.statut= "attente"
    end

    respond_to do |format|
      if @disponibilite.save
        format.html { redirect_to @disponibilite, notice: 'Disponibilite was successfully created.' }
        format.json { render action: 'show', status: :created, location: @disponibilite }
      else
        set_disponibilites_avenir

        format.html { render action: 'new' }
        format.json { render json: @disponibilite.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /disponibilites/1
  def update
    respond_to do |format|
      if @disponibilite.update(disponibilite_params)
        format.html { redirect_to @disponibilite, notice: 'Disponibilite was successfully updated.' }
        format.json { head :no_content }
      else
        set_disponibilites_avenir

        @utilisateur_absent = Utilisateur.where("titre = 'permanent'").all
        format.html { render action: 'edit' }
        format.json { render json: @disponibilite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /disponibilites/1
  def destroy
    @disponibilite.destroy
    respond_to do |format|
      format.html { redirect_to disponibilites_url }
      format.json { head :no_content }
    end
  end

  def for_calendar
    liste_disponibilites = Disponibilite.where("date_heure_debut between :date_debut and :date_fin", {date_debut: Time.at(params[:start].to_i).to_date, date_fin: Time.at(params[:end].to_i).to_date})
    @events = liste_disponibilites.map do |d|
      { :id => d.id,
        :title => d.date_heure_debut.strftime("%H:%M") + " - " + d.date_heure_fin.strftime("%H:%M"),
        :className => d.statut.eql?("attribue") ? "event-green" : d.statut.eql?("attente") ? "event-orange" : "event-red",
        :start => d.date_heure_debut.strftime("%Y/%m/%d"),
        :end => d.date_heure_fin.strftime("%Y/%m/%d"),
        :url => disponibilite_path(d)}
    end

    render json: @events

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_disponibilite
      @disponibilite = Disponibilite.find(params[:id])
    end

    def set_disponibilites_avenir
      @disponibilites_avenir = get_disponibilites_avenir_non_attribue
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def disponibilite_params
      params.require(:disponibilite).permit(:utilisateur_absent_id, :utilisateur_remplacant_id, :endroit_id, :niveau_id, :date_heure_debut, :date_heure_fin, :surveillance, :specialite, :notes, :statut, :created_at, :updated_at)
    end
end
