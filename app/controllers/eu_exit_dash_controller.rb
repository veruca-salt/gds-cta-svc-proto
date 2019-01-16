class EuExitDashController < ApplicationController
  before_action :authenticate_user!

  def index
    @departments = Department.all
    @systems = SystemDepartment.all
    @system_links = SystemLink.all
    @system = System.all
  end

  # GET /get_systems_by_dept/:department_id
  def get_systems_by_dept
  	system_list = []
    system_departments = SystemDepartment.where("department_id = ?", params[:department_id]).each do | sys |
    	sys_info = sys.attributes # add all attributes from system department
    	sys_info[:sys_name] = sys.system.acronymn # add the system name from system to display
    	system_list << sys_info # add it to the array
    end

    respond_to do |format|
      format.json { render :json => system_list }
    end
  end

  private
  def authenticate_user!
   redirect_to :login if current_user.nil?
  end

end
