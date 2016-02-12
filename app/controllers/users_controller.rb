class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @users = User.all
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    if @user.save
      redirect_to @user, notice: t("user.messages.save_creation_succes")
    else
      render action: "new"
    end
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    if @user.update(user_params)
      redirect_to @user, notice: t("user.messages.save_modification_succes")
    else
      render action: "edit"
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  private
    def user_params
      params.require(:user).permit(:email, :message_texte_permis, :niveau, :nom, :numero_cellulaire, :numero_telephone, :prenom, :titre, :password, :role_ids)
    end
end
