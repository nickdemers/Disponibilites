class UsersController < ApplicationController
  before_action :authenticate_user!
  #before_action :set_user, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  before_action :set_disponibilites_avenir, only: [:index, :show, :new, :edit]

  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    #@user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    #@user = User.new(user_params)
    respond_to do |format|
      if params[:user][:password].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end
      if @user.save
        format.html { redirect_to @user, notice: t("user.messages.save_creation_succes") }
        format.json { render json: @user, status: :created, location: @user }
      else
        set_disponibilites_avenir

        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    respond_to do |format|
      if params[:user][:password].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      #else
      #  @user.password = params[:user][:password]
      end
      if @user.update(user_params)
        format.html { redirect_to @user, notice: t("user.messages.save_modification_succes") }
        format.json { head :no_content }
      else
        set_disponibilites_avenir

        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_path }
      format.json { head :no_content }
    end
  end

  private
    #def set_user
    #  @user = User.find(params[:id])
    #end

    def set_disponibilites_avenir
      @disponibilites_avenir = get_disponibilites_avenir_non_attribue
    end

    def user_params
      params.require(:user).permit(:email, :message_texte_permis, :niveau, :nom, :numero_cellulaire, :numero_telephone, :prenom, :titre, :password, :role_ids)
    end
end
