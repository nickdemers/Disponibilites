class DisponibilitesController < ApplicationController
  include UsersHelper
  include DisponibilitesHelper
  include DisponibilitesConcern

  before_action :authenticate_user!
  load_and_authorize_resource :except => [:for_calendar]

  # GET /disponibilites
  def index
    date = Date.new(Date.current.year, Date.current.month, 01)
    date_debut = params[:date_debut] ||= date.strftime("%Y/%m/%d")
    date_fin = params[:date_fin]
    current_page = params[:page] ||= 1

    if current_user.role? :admin or current_user.role? :super_admin then
      @disponibilites = Disponibilite.by_date_debut(date_debut).by_date_fin(date_fin).order_by_date_heure_debut.page(current_page).per(20)
    elsif current_user.role? :permanent then
      @disponibilites = Disponibilite.by_user_absent(current_user.id).by_date_debut(date_debut).by_date_fin(date_fin).order_by_date_heure_debut.page(current_page).per(20)
    elsif current_user.role? :remplacant then
      @disponibilites = Disponibilite.by_user_remplacant(current_user.id).by_date_debut(date_debut).by_date_fin(date_fin).order_by_date_heure_debut.page(current_page).per(20)
    end
  end

  # GET /disponibilites/new
  def new
    obtain_user_absent

    respond_to do |format|
      if @user_absent.blank?
        format.html { redirect_to disponibilites_url, alert: t("disponibilite.erreurs.aucun_user_absent_disponible") }
        #format.json { head :no_content }
       else
         format.html # new.html.erb
        #format.json { render json: @disponibilite }
      end
    end
  end

  # GET /disponibilites/1/edit
  def edit
    obtain_user_absent
    @disabled = false
    @disabled = true if current_user.role? :remplacant
    @date_heure_limit_answer = date_heure_limit_answer(@disponibilite)
  end

  # POST /disponibilites
  def create
    @user_remplacant = User.find_by_next_user_remplacant_available(@disponibilite.date_heure_debut, @disponibilite.date_heure_fin)

    @disponibilite.date_time_expired = DateTime.current + 3.hours
    @disponibilite.user_remplacant = @user_remplacant unless @user_remplacant.nil?
    @disponibilite.statut = "waiting"

    respond_to do |format|

      if @disponibilite.save

        #if !@user_remplacant.nil?
        #  @user_remplacant.each_with_index do |remplacant, index|
            #demande = Demande.new(:user => remplacant, :disponibilite => @disponibilite, :status => "waiting", :priority => index)
            #demande.save
        #    DisponibiliteMailer.nouvelle_disponibilite_email(remplacant, @disponibilite).deliver_later
        #  end
        #end

        unless @user_remplacant.nil?
          DisponibiliteMailer.nouvelle_disponibilite_email(@disponibilite.user_remplacant, @disponibilite).deliver_later
        end

        format.html { redirect_to edit_disponibilite_path(id: @disponibilite.id), notice: t("disponibilite.messages.save_creation_succes") }
        #format.json { render action: 'show', status: :created, location: @disponibilite }
      else
        obtain_user_absent

        format.html { render action: 'new' }
        #format.json { render json: @disponibilite.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /disponibilites/1
  def update
    respond_to do |format|
      if @disponibilite.update(disponibilite_params)
        format.html { redirect_to edit_disponibilite_path(id: @disponibilite.id), notice: t("disponibilite.messages.save_modification_succes") }
        #format.json { head :no_content }
      else
        obtain_user_absent
        format.html { render action: 'edit' }
        #format.json { render json: @disponibilite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /disponibilites/1
  def destroy
    @disponibilite.destroy
    respond_to do |format|
      format.html { redirect_to disponibilites_url }
      #format.json { head :no_content }
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
          :title_msg => d.date_heure_debut.strftime("%Y/%m/%d %l:%M %p") + " - " + d.date_heure_fin.strftime("%Y/%m/%d %l:%M %p"),
          :nom_ecole => d.ecole.nom,
          :nom_niveau => get_description_niveau(d.niveau_id),
          :nom_user_absent => get_user_absent_nom_format(d)}
      end
    end

    render json: @events
  end

  def accept_availability
    @disponibilite.statut= "assigned"

    respond_to do |format|
      if !is_time_expired?(@disponibilite.date_time_expired)
        if @disponibilite.save
          format.html { redirect_to edit_disponibilite_path(id: @disponibilite.id), notice: t("disponibilite.messages.accept_availability_succes") }
          #format.json { head :no_content }
        else
          format.html { redirect_to edit_disponibilite_path(id: @disponibilite.id), warning: t("disponibilite.messages.accept_availability_error") }
          #format.json { render json: @disponibilite.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to edit_disponibilite_path(id: @disponibilite.id), warning: t("disponibilite.messages.accept_availability_time_expired") }
      end
    end
  end

  def deny_availability
    @disponibilite.statut= "denied"

    respond_to do |format|
      if !is_time_expired?(@disponibilite.date_time_expired)

        # TODO ND ne pas chercher dans les remplacants celui qui vient de la refuser..
        @user_remplacant = User.find_by_next_user_remplacant_available(@disponibilite.date_heure_debut, @disponibilite.date_heure_fin)
        if @user_remplacant.nil?
          @disponibilite.user_remplacant = nil
        else
          @disponibilite.user_remplacant = @user_remplacant
          @disponibilite.date_time_expired = DateTime.current + 3.hours
          @disponibilite.statut = "waiting"
        end

        if @disponibilite.save
          format.html { redirect_to disponibilites_path, notice: t("disponibilite.messages.deny_availability_success") }
          #format.json { head :no_content }
        else
          format.html { redirect_to edit_disponibilite_path(id: @disponibilite.id), warning: t("disponibilite.messages.deny_availability_error") }
          #format.json { render json: @disponibilite.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to edit_disponibilite_path(id: @disponibilite.id), warning: t("disponibilite.messages.deny_availability_time_expired") }
      end
    end
  end

  protected
    def obtain_user_absent
      if current_user.role? :admin or current_user.role? :super_admin then
        @user_absent = User.where(:titre => 'permanent')
      elsif current_user.role? :permanent then
        @user_absent = User.where(id: current_user.id)
      elsif current_user.role? :remplacant then
        @user_absent = User.where(id: @disponibilite.user_absent_id)
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def disponibilite_params
      params.require(:disponibilite).permit(:user_absent_id, :user_remplacant_id, :niveau_id, :date_heure_debut, :date_heure_fin, :surveillance, :specialite, :notes, :statut, :created_at, :updated_at, :ecole_id)
    end
end
