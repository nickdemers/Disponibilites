class DisponibilitesController < ApplicationController
  include UsersHelper
  include DisponibilitesHelper
  include DisponibilitesConcern

  before_action :authenticate_user!
  load_and_authorize_resource :except => [:for_calendar]

  before_action :obtain_user_absent, only: [:new, :edit]

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

  def new
    @disabled = false
    redirect_to disponibilites_url, alert: t("disponibilite.erreurs.aucun_user_absent_disponible") if @user_absent.blank?
  end

  def edit
    @disabled = false
    @disabled = true if current_user.role? :remplacant or @disponibilite.statut == "canceled"
    @date_heure_limit_answer = date_heure_limit_answer(@disponibilite)
  end

  def create
    @user_remplacant = User.find_by_next_user_remplacant_available(@disponibilite.date_heure_debut, @disponibilite.date_heure_fin, nil)

    @disponibilite.date_time_expired = DateTime.current + 3.hours
    @disponibilite.user_remplacant = @user_remplacant unless @user_remplacant.nil?
    @disponibilite.statut = "waiting"

    if @disponibilite.save

      unless @user_remplacant.nil?
        Demande.create!(user_id: @user_remplacant.id, disponibilite_id: @disponibilite.id, status: "waiting")
        DisponibiliteMailer.nouvelle_disponibilite_email(@disponibilite.user_remplacant, @disponibilite).deliver_later
      end

      redirect_to edit_disponibilite_path(id: @disponibilite.id), notice: t("disponibilite.messages.save_creation_succes")
    else
      obtain_user_absent

      render action: 'new'
    end
  end

  def update
    if @disponibilite.update(disponibilite_params)
      redirect_to edit_disponibilite_path(id: @disponibilite.id), notice: t("disponibilite.messages.save_modification_succes")
    else
      obtain_user_absent
      render action: 'edit'
    end
  end

  def cancel
    @disponibilite.statut = "canceled"
    @disponibilite.user_remplacant = nil
    @disponibilite.date_time_expired = nil
    if @disponibilite.save
      redirect_to edit_disponibilite_path(id: @disponibilite.id), notice: t("disponibilite.messages.save_cancel_succes")
    else
      obtain_user_absent
      render action: 'edit'
    end
  end

  # def destroy
  #   @disponibilite.destroy
  #   redirect_to disponibilites_url
  # end

  def for_calendar
    liste_disponibilites = get_disponibilites(Time.at(params[:start].to_i).to_date,Time.at(params[:end].to_i).to_date)
    unless liste_disponibilites.nil?
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

    if is_time_expired?(@disponibilite.date_time_expired)
      redirect_to edit_disponibilite_path(id: @disponibilite.id), warning: t("disponibilite.messages.accept_availability_time_expired")
    else
      if @disponibilite.save
        redirect_to edit_disponibilite_path(id: @disponibilite.id), notice: t("disponibilite.messages.accept_availability_succes")
      else
        redirect_to edit_disponibilite_path(id: @disponibilite.id), warning: t("disponibilite.messages.accept_availability_error")
      end
    end
  end

  def deny_availability
    @disponibilite.statut= "denied"

    if is_time_expired?(@disponibilite.date_time_expired)
      redirect_to edit_disponibilite_path(id: @disponibilite.id), warning: t("disponibilite.messages.deny_availability_time_expired")
    else
      @user_remplacant = User.find_by_next_user_remplacant_available(@disponibilite.date_heure_debut, @disponibilite.date_heure_fin, @disponibilite.id)
      if @user_remplacant.nil?
        @disponibilite.user_remplacant = nil
        @disponibilite.date_time_expired = nil
      else
        @disponibilite.user_remplacant = @user_remplacant
        @disponibilite.date_time_expired = DateTime.current + 3.hours
        @disponibilite.statut = "waiting"

        Demande.create!(user_id: @user_remplacant.id, disponibilite_id: @disponibilite.id, status: "waiting")
      end

      if @disponibilite.save
        redirect_to disponibilites_path, notice: t("disponibilite.messages.deny_availability_success")
      else
        redirect_to edit_disponibilite_path(id: @disponibilite.id), warning: t("disponibilite.messages.deny_availability_error")
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
