class SystemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_system, only: [:show, :edit, :update, :destroy]

  # GET /systems
  # GET /systems.json
  def index
    @systems = System.all
  end

  # GET /systems/1
  # GET /systems/1.json
  def show
    # get department name
    SystemDepartment.where("system_id=?", params[:id]).each do | deptid |
      Department.where("id=?", deptid.department_id).each do | dept |
        @dept_name = dept.name    #get the department name for display
      end
    end

    # get list of linked systems
    linked_systems = []
    SystemLink.select("system_b_id").where(["system_a_id = ? AND weight=1", params[:id]]).each do | links |
      System.where("id=?", links.system_b_id).each do | sys |
        linked_systems << sys.name
      end
    end
    @syslinks = linked_systems
    
  end

  # GET /systems/new
  def new
    @system = System.new
    @system.system_departments.build
    @system.system_links.build
  end

  # GET /systems/1/edit
  def edit
  end

  # POST /systems
  # POST /systems.json
  def create
    @system = System.new(system_params)
    respond_to do |format|
      if @system.save

        # if department or system links exist then create the respective links using the returned new system id
        # remove all first and rebuild


        format.html { redirect_to @system, notice: 'System was successfully created.' }
        format.json { render :show, status: :created, location: @system }
      else
        format.html { render :new }
        format.json { render json: @system.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /systems/1
  # PATCH/PUT /systems/1.json
  def update
    respond_to do |format|
      if @system.update(system_params)
        format.html { redirect_to @system, notice: 'System was successfully updated.' }
        format.json { render :show, status: :ok, location: @system }
      else
        format.html { render :edit }
        format.json { render json: @system.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /systems/1
  # DELETE /systems/1.json
  def destroy
    # If any system department links exist delete them
    @system_departments = SystemDepartment.where("system_id = ?", @system)&.destroy_all
    # If any system to system links exist delete them
    @system_links = SystemLink.where("system_a_id = ? OR system_b_id = ?", @system, @system)&.destroy_all

    @system.destroy
    respond_to do |format|
      format.html { redirect_to systems_url, notice: 'System was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_system
      @system = System.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def system_params
      params.require(:system).permit(:id, :acronymn, :name, :description, :importance, system_departments_attributes: [:id, :system_id, :department_id], :system_links_attributes => {})
    end

  def authenticate_user!
   redirect_to :login if current_user.nil?
  end
end
