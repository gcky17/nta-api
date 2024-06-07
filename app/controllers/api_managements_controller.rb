class ApiManagementsController < ApplicationController
  before_action :set_api_management, only: %i[ show edit update destroy ]

  # GET /api_managements or /api_managements.json
  def index
    @api_managements = ApiManagement.all
  end

  # GET /api_managements/1 or /api_managements/1.json
  def show
  end

  # GET /api_managements/new
  def new
    @api_management = ApiManagement.new
  end

  # GET /api_managements/1/edit
  def edit
  end

  # POST /api_managements or /api_managements.json
  def create
    @api_management = ApiManagement.new(api_management_params)

    respond_to do |format|
      if @api_management.save
        format.html { redirect_to api_management_url(@api_management), notice: "Api management was successfully created." }
        format.json { render :show, status: :created, location: @api_management }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @api_management.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api_managements/1 or /api_managements/1.json
  def update
    respond_to do |format|
      if @api_management.update(api_management_params)
        format.html { redirect_to api_management_url(@api_management), notice: "Api management was successfully updated." }
        format.json { render :show, status: :ok, location: @api_management }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @api_management.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api_managements/1 or /api_managements/1.json
  def destroy
    @api_management.destroy!

    respond_to do |format|
      format.html { redirect_to api_managements_url, notice: "Api management was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_management
      @api_management = ApiManagement.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_management_params
      params.require(:api_management).permit(:request, :response, :count, :wtime, :comment)
    end
end
