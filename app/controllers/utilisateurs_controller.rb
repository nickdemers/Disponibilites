class UtilisateursController < ApplicationController
  #before_action :authenticate_utilisateur!
  #before_action :set_utilisateur, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  before_action :set_disponibilites_avenir, only: [:index, :show, :new, :edit]

  # GET /utilisateurs
  # GET /utilisateurs.json
  def index
    @utilisateurs = Utilisateur.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @utilisateurs }
    end
  end

  # GET /utilisateurs/1
  # GET /utilisateurs/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @utilisateur }
    end
  end

  # GET /utilisateurs/new
  # GET /utilisateurs/new.json
  def new
    #@utilisateur = Utilisateur.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @utilisateur }
    end
  end

  # GET /utilisateurs/1/edit
  def edit
  end

  # POST /utilisateurs
  # POST /utilisateurs.json
  def create
    #@utilisateur = Utilisateur.new(utilisateur_params)
    respond_to do |format|
      if params[:utilisateur][:password].blank?
        params[:utilisateur].delete(:password)
        params[:utilisateur].delete(:password_confirmation)
      end
      if @utilisateur.save
        format.html { redirect_to @utilisateur, notice: t("utilisateur.messages.save_creation_succes") }
        format.json { render json: @utilisateur, status: :created, location: @utilisateur }
      else
        set_disponibilites_avenir

        format.html { render action: "new" }
        format.json { render json: @utilisateur.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /utilisateurs/1
  # PUT /utilisateurs/1.json
  def update
    respond_to do |format|
      if params[:utilisateur][:password].blank?
        params[:utilisateur].delete(:password)
        params[:utilisateur].delete(:password_confirmation)
      #else
      #  @utilisateur.password = params[:utilisateur][:password]
      end
      if @utilisateur.update(utilisateur_params)
        format.html { redirect_to @utilisateur, notice: t("utilisateur.messages.save_modification_succes") }
        format.json { head :no_content }
      else
        set_disponibilites_avenir

        format.html { render action: "edit" }
        format.json { render json: @utilisateur.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /utilisateurs/1
  # DELETE /utilisateurs/1.json
  def destroy
    @utilisateur.destroy

    respond_to do |format|
      format.html { redirect_to utilisateurs_path }
      format.json { head :no_content }
    end
  end

  private
    #def set_utilisateur
    #  @utilisateur = Utilisateur.find(params[:id])
    #end

    def set_disponibilites_avenir
      @disponibilites_avenir = get_disponibilites_avenir_non_attribue
    end

    def utilisateur_params
      params.require(:utilisateur).permit(:email, :message_texte_permis, :niveau, :nom, :numero_cellulaire, :numero_telephone, :prenom, :titre, :password, :role_ids)
    end
end
