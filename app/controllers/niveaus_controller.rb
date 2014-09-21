class NiveausController < ApplicationController
  before_action :set_niveau, only: [:show, :edit, :update, :destroy]

  # GET /niveaus
  # GET /niveaus.json
  def index
    @niveaus = Niveau.all
  end

  # GET /niveaus/1
  # GET /niveaus/1.json
  def show
  end

  # GET /niveaus/new
  def new
    @niveau = Niveau.new
  end

  # GET /niveaus/1/edit
  def edit
  end

  # POST /niveaus
  # POST /niveaus.json
  def create
    @niveau = Niveau.new(niveau_params)

    respond_to do |format|
      if @niveau.save
        format.html { redirect_to @niveau, notice: 'Niveau was successfully created.' }
        format.json { render action: 'show', status: :created, location: @niveau }
      else
        format.html { render action: 'new' }
        format.json { render json: @niveau.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /niveaus/1
  # PATCH/PUT /niveaus/1.json
  def update
    respond_to do |format|
      if @niveau.update(niveau_params)
        format.html { redirect_to @niveau, notice: 'Niveau was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @niveau.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /niveaus/1
  # DELETE /niveaus/1.json
  def destroy
    @niveau.destroy
    respond_to do |format|
      format.html { redirect_to niveaus_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_niveau
      @niveau = Niveau.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def niveau_params
      params.require(:niveau).permit(:nom, :created_at, :updated_at)
    end
end
