class RolesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_role, only: [:show, :edit, :update, :destroy]

  def index
    @roles = Role.all
  end

  def show
  end

  def new
    @role = Role.new
  end

  def edit
  end

  def create
    @role = Role.new(role_params)
    if @role.save
      redirect_to @role, notice: t("role.messages.save_creation_succes")
    else
      render action: "new"
    end
  end

  def update
    if @role.update(role_params)
      redirect_to @role, notice: t("role.messages.save_modification_succes")
    else
      render action: "edit"
    end
  end

  def destroy
    @role.destroy
    redirect_to roles_path
  end

  private
    def set_role
      @role = Role.find(params[:id])
    end

    def role_params
      params.require(:role).permit(:nom)
    end
end
