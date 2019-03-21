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
      #puts "here..............1 #{system_list.inspect}"
    end

    respond_to do |format|
      format.json { render :json => system_list }
    end
  end

  # GET /impact/:system_id
  def impact
    # get all systems attached to system a
    system_list = []
    SystemLink.select("id, system_b_id").where(["system_a_id = ? AND weight=1", params[:system_id]]).find_each do | sys |
      sys_info = sys.attributes
      sys_info[:sys_ac] = sys.system_b.acronymn
      sys_info[:sys_nm] = sys.system_b.name
      # add children systems
      sys_info[:children] = get_children(sys)
      system_list << sys_info
    end

    respond_to do |format|
      puts "here..............1 #{system_list.inspect}"
      format.json { render :json => system_list }
    end
  end
  # only goes to lvl 2, need to recurse
  def get_children(parent)
    system_list = []
    SystemLink.select("id, system_b_id").where(["system_a_id = ? AND weight=1", parent.system_b_id]).find_each do | sys |
      return if sys == nil
      sys_info = sys.attributes
      sys_info[:sys_ac] = sys.system_b.acronymn
      sys_info[:sys_nm] = sys.system_b.name
      system_list << sys_info
      return system_list
    end
  end


  private
  def authenticate_user!
   redirect_to :login if current_user.nil?
  end

end
