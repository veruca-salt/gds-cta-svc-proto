class SystemDepartmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_system_department, only: [:show, :edit, :update, :destroy]

  # GET /system_departments
  # GET /system_departments.json
  def index
    @system_departments = SystemDepartment.all
  end

  # GET /system_departments/1
  # GET /system_departments/1.json
  def show
    
  end

  # GET /system_departments/new
  def new
    @system_department = SystemDepartment.new
  end

  # GET /system_departments/1/edit
  def edit
  end

  # POST /system_departments
  # POST /system_departments.json
  def create
    @system_department = SystemDepartment.new(system_department_params)

    respond_to do |format|
      if @system_department.save
        format.html { redirect_to @system_department, notice: 'System department was successfully created.' }
        format.json { render :show, status: :created, location: @system_department }
      else
        format.html { render :new }
        format.json { render json: @system_department.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /system_departments/1
  # PATCH/PUT /system_departments/1.json
  def update
    respond_to do |format|
      if @system_department.update(system_department_params)
        format.html { redirect_to @system_department, notice: 'System department was successfully updated.' }
        format.json { render :show, status: :ok, location: @system_department }
      else
        format.html { render :edit }
        format.json { render json: @system_department.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /system_departments/1
  # DELETE /system_departments/1.json
  def destroy
    @system_department.destroy
    respond_to do |format|
      format.html { redirect_to system_departments_url, notice: 'System department was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_system_department
      @system_department = SystemDepartment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def system_department_params
      params.require(:system_department).permit(:system_id, :department_id)
    end

    def authenticate_user!
   redirect_to :login if current_user.nil?
  end
end
