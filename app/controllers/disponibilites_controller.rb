class DisponibilitesController < ApplicationController
  before_action :authenticate_utilisateur!
  before_action :set_disponibilite, only: [:show, :edit, :update, :destroy, :accepter_disponibilite]
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
    @utilisateur_absent = Utilisateur.where(:titre => 'permanent')

    respond_to do |format|
      if !@utilisateur_absent.blank?
        @disponibilite = Disponibilite.new
        format.html # new.html.erb
        format.json { render json: @disponibilite }
      else
        format.html { redirect_to disponibilites_url, alert: t("disponibilite.erreurs.aucun_utilisateur_absent_disponible") }
        format.json { head :no_content }
      end
    end
  end

  # GET /disponibilites/1/edit
  def edit
    @utilisateur_absent = Utilisateur.where(:titre => 'permanent')

    if !@disponibilite.utilisateur_remplacant.nil?
      @utilisateur_remplacant = Utilisateur.find @disponibilite.utilisateur_remplacant
    end
  end

  # POST /disponibilites
  def create
    @disponibilite = Disponibilite.new(disponibilite_params)

    @utilisateur_remplacant = Utilisateur.order("id").joins(:disponibilites_remplacant).where(["titre = 'remplacant' and ((? < disponibilites.date_heure_debut) or (? > disponibilites.date_heure_fin))", @disponibilite.date_heure_fin, @disponibilite.date_heure_debut]).first

    if !@utilisateur_remplacant.nil?
      @disponibilite.utilisateur_remplacant= @utilisateur_remplacant
      @disponibilite.statut= "attente"
    end

    respond_to do |format|
      if @disponibilite.save

        if !@utilisateur_remplacant.nil?
          DisponibiliteMailer.nouvelle_disponibilite_email(@disponibilite.utilisateur_remplacant, @disponibilite).deliver_later
        end

        format.html { redirect_to @disponibilite, notice: t("disponibilite.messages.save_creation_succes") }
        format.json { render action: 'show', status: :created, location: @disponibilite }
      else
        @utilisateur_absent = Utilisateur.where(:titre => 'permanent')

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
        format.html { redirect_to @disponibilite, notice: t("disponibilite.messages.save_modification_succes") }
        format.json { head :no_content }
      else
        set_disponibilites_avenir

        @utilisateur_absent = Utilisateur.where(:titre => 'permanent')
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
    liste_disponibilites = get_disponibilites(Time.at(params[:start].to_i).to_date,Time.at(params[:end].to_i).to_date)
    if !liste_disponibilites.nil? then
      @events = liste_disponibilites.map do |d|
        { :id => d.id,
          :title => d.date_heure_debut.strftime("%H:%M") + " - " + d.date_heure_fin.strftime("%H:%M"),
          :className => d.statut.eql?("attribue") ? "event-green" : d.statut.eql?("attente") ? "event-orange" : "event-red",
          :start => d.date_heure_debut.strftime("%Y/%m/%d"),
          :end => d.date_heure_fin.strftime("%Y/%m/%d"),
          :url => disponibilite_path(d),
          :nom_utilisateur_absent => d.utilisateur_absent.prenom}
      end
    end

    render json: @events

  end

  def accepter_disponibilite
    @disponibilite.statut= "attribue"

    respond_to do |format|
      if @disponibilite.save
        format.html { redirect_to @disponibilite, notice: t("disponibilite.messages.save_modification_succes") }
        format.json { head :no_content }
      else
        set_disponibilites_avenir

        @utilisateur_absent = Utilisateur.where(:titre => 'permanent')
        format.html { redirect_to @disponibilite }
        format.json { render json: @disponibilite.errors, status: :unprocessable_entity }
      end
    end
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
      params.require(:disponibilite).permit(:utilisateur_absent_id, :utilisateur_remplacant_id, :niveau_id, :date_heure_debut, :date_heure_fin, :surveillance, :specialite, :notes, :statut, :created_at, :updated_at, :ecole_id)
    end
end
