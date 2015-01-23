class RolesController < ApplicationController
  before_action :authenticate_utilisateur!
  before_action :set_role, only: [:show, :edit, :update, :destroy]

  def index
    @roles = Role.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @roles }
    end
  end

  def show
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @role }
    end
  end

  def new
    @role = Role.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @role }
    end
  end

  def edit
  end

  def create
    @role = Role.new(role_params)
    respond_to do |format|
      if @role.save
        format.html { redirect_to @role, notice: t("role.messages.save_creation_succes") }
        format.json { render json: @role, status: :created, location: @role }
      else
        format.html { render action: "new" }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @role.update(role_params)
        format.html { redirect_to @role, notice: t("role.messages.save_modification_succes") }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @role.destroy

    respond_to do |format|
      format.html { redirect_to roles_path }
      format.json { head :no_content }
    end
  end

  private
    def set_role
      @role = Role.find(params[:id])
    end

    def role_params
      params.require(:role).permit(:nom)
    end
end
