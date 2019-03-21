class AgenciesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_agency, only: [:show, :edit, :update, :destroy]

  # GET /agencies
  # GET /agencies.json
  def index
    @agencies = Agency.all
  end

  # GET /agencies/1
  # GET /agencies/1.json
  def show
  end

  # GET /agencies/new
  def new
    @agency = Agency.new
  end

  # GET /agencies/1/edit
  def edit
  end

  # GET /agencies/add/:agency_name
  def add
    agency_find_results = Agency.where("name = ?", params[:agency_name])

    # agency exists, just return 
    if agency_find_results.exists?
      respond_to do |format|
        format.json { render json: agency_find_results }
      end
    else
     # add new program to the db and then return the new program
     new_agency = Agency.create(name: params[:agency_name])
       if new_agency.save  
         # Need to select values to return otherwise returns undefined
         agency_list = []
         agency_info = new_agency.attributes
         agency_list << agency_info 
         respond_to do |format|
            format.json { render json: agency_list }
         end
       end
    end
  end


  # POST /agencies
  # POST /agencies.json
  def create
    @agency = Agency.new(agency_params)

    respond_to do |format|
      if @agency.save
        format.html { redirect_to @agency, notice: 'Agency was successfully created.' }
        format.json { render :show, status: :created, location: @agency }
      else
        format.html { render :new }
        format.json { render json: @agency.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /agencies/1
  # PATCH/PUT /agencies/1.json
  def update
    respond_to do |format|
      if @agency.update(agency_params)
        format.html { redirect_to @agency, notice: 'Agency was successfully updated.' }
        format.json { render :show, status: :ok, location: @agency }
      else
        format.html { render :edit }
        format.json { render json: @agency.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /agencies/1
  # DELETE /agencies/1.json
  def destroy
    @agency.destroy
    respond_to do |format|
      format.html { redirect_to agencies_url, notice: 'Agency was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_agency
      @agency = Agency.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def agency_params
      params.require(:agency).permit(:name, :agency_name)
    end

  def authenticate_user!
   redirect_to :login if current_user.nil?
  end
end
