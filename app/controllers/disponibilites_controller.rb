class DisponibilitesController < ApplicationController
  before_action :authenticate_user!
  #before_action :set_disponibilite, only: [:show, :edit, :update, :destroy, :accepter_disponibilite]
  load_and_authorize_resource
  before_action :set_disponibilites_avenir, only: [:index, :show, :new, :edit]

  # GET /disponibilites
  def index
    if current_user.role? :admin or current_user.role? :super_admin then
      @disponibilites = Disponibilite.all.order("date_heure_debut").first(10)
    elsif current_user.role? :permanent then
      @disponibilites = Disponibilite.where("user_absent_id = :user_absent_id", {user_absent_id: current_user.id}).order("date_heure_debut").first(10)
    elsif current_user.role? :remplacant then
      @disponibilites = Disponibilite.where("user_remplacant_id = :user_remplacant_id", {user_remplacant_id: current_user.id}).order("date_heure_debut").first(10)
    end
    #if !@disponibilites.nil? then
    #  @disponibilites.order("date_heure_debut").first(10)
    #end
  end

  # GET /disponibilites/1
  def show
    @user_absent = User.find(@disponibilite.user_absent)

    if !@disponibilite.user_remplacant.nil?
      @user_remplacant = User.find(@disponibilite.user_remplacant)
    end
  end

  # GET /disponibilites/new
  def new
    @user_absent = User.where(:titre => 'permanent')

    respond_to do |format|
      if !@user_absent.blank?
        format.html # new.html.erb
        format.json { render json: @disponibilite }
      else
        format.html { redirect_to disponibilites_url, alert: t("disponibilite.erreurs.aucun_user_absent_disponible") }
        format.json { head :no_content }
      end
    end
  end

  # GET /disponibilites/1/edit
  def edit
    @user_absent = User.where(:titre => 'permanent')

    if !@disponibilite.user_remplacant.nil?
      @user_remplacant = User.find @disponibilite.user_remplacant
    end
  end

  # POST /disponibilites
  def create
    @user_remplacant = User.order("id").joins(:disponibilites_remplacant).where(["titre = 'remplacant' and ((? < disponibilites.date_heure_debut) or (? > disponibilites.date_heure_fin))", @disponibilite.date_heure_fin, @disponibilite.date_heure_debut]).first

    if !@user_remplacant.nil?
      @disponibilite.user_remplacant= @user_remplacant
      @disponibilite.statut= "waiting"
    end

    respond_to do |format|
      if @disponibilite.save

        if !@user_remplacant.nil?
          DisponibiliteMailer.nouvelle_disponibilite_email(@disponibilite.user_remplacant, @disponibilite).deliver_later
        end

        format.html { redirect_to @disponibilite, notice: t("disponibilite.messages.save_creation_succes") }
        format.json { render action: 'show', status: :created, location: @disponibilite }
      else
        @user_absent = User.where(:titre => 'permanent')

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

        @user_absent = User.where(:titre => 'permanent')
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
          :className => d.statut.eql?("assigned") ? "event-green" : d.statut.eql?("waiting") ? "event-orange" : "event-red",
          :start => d.date_heure_debut.strftime("%Y/%m/%d"),
          :end => d.date_heure_fin.strftime("%Y/%m/%d"),
          :url => disponibilite_path(d),
          :nom_user_absent => d.user_absent.prenom}
      end
    end

    render json: @events

  end

  def accept_availability
    @disponibilite.statut= "assigned"

    respond_to do |format|
      if @disponibilite.save
        format.html { redirect_to @disponibilite, notice: t("disponibilite.messages.save_modification_succes") }
        format.json { head :no_content }
      else
        set_disponibilites_avenir

        @user_absent = User.where(:titre => 'permanent')
        format.html { redirect_to @disponibilite }
        format.json { render json: @disponibilite.errors, status: :unprocessable_entity }
      end
    end
  end

  def deny_availability
    @disponibilite.statut= "denied"

    respond_to do |format|
      if @disponibilite.save
        format.html { redirect_to @disponibilite, notice: t("disponibilite.messages.save_modification_succes") }
        format.json { head :no_content }
      else
        set_disponibilites_avenir

        @user_absent = User.where(:titre => 'permanent')
        format.html { redirect_to @disponibilite }
        format.json { render json: @disponibilite.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    #def set_disponibilite
    #  @disponibilite = Disponibilite.find(params[:id])
    #end

    def set_disponibilites_avenir
      @disponibilites_avenir = get_disponibilites_avenir_non_attribue
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def disponibilite_params
      params.require(:disponibilite).permit(:user_absent_id, :user_remplacant_id, :niveau_id, :date_heure_debut, :date_heure_fin, :surveillance, :specialite, :notes, :statut, :created_at, :updated_at, :ecole_id)
    end
end
