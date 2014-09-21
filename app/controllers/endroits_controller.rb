class EndroitsController < ApplicationController
  before_action :set_endroit, only: [:show, :edit, :update, :destroy]

  # GET /endroits
  # GET /endroits.json
  def index
    @endroits = Endroit.all
  end

  # GET /endroits/1
  # GET /endroits/1.json
  def show
  end

  # GET /endroits/new
  def new
    @endroit = Endroit.new
  end

  # GET /endroits/1/edit
  def edit
  end

  # POST /endroits
  # POST /endroits.json
  def create
    @endroit = Endroit.new(endroit_params)

    respond_to do |format|
      if @endroit.save
        format.html { redirect_to @endroit, notice: 'Endroit was successfully created.' }
        format.json { render action: 'show', status: :created, location: @endroit }
      else
        format.html { render action: 'new' }
        format.json { render json: @endroit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /endroits/1
  # PATCH/PUT /endroits/1.json
  def update
    respond_to do |format|
      if @endroit.update(endroit_params)
        format.html { redirect_to @endroit, notice: 'Endroit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @endroit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /endroits/1
  # DELETE /endroits/1.json
  def destroy
    @endroit.destroy
    respond_to do |format|
      format.html { redirect_to endroits_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_endroit
      @endroit = Endroit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def endroit_params
      params.require(:endroit).permit(:nom, :adresse, :numero_telephone, :created_at, :updated_at)
    end
end
