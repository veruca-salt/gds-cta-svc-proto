require 'test_helper'

class SystemDepartmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @system_department = system_departments(:one)
  end

  test "should get index" do
    get system_departments_url
    assert_response :success
  end

  test "should get new" do
    get new_system_department_url
    assert_response :success
  end

  test "should create system_department" do
    assert_difference('SystemDepartment.count') do
      post system_departments_url, params: { system_department: { department_id: @system_department.department_id, system_id: @system_department.system_id } }
    end

    assert_redirected_to system_department_url(SystemDepartment.last)
  end

  test "should show system_department" do
    get system_department_url(@system_department)
    assert_response :success
  end

  test "should get edit" do
    get edit_system_department_url(@system_department)
    assert_response :success
  end

  test "should update system_department" do
    patch system_department_url(@system_department), params: { system_department: { department_id: @system_department.department_id, system_id: @system_department.system_id } }
    assert_redirected_to system_department_url(@system_department)
  end

  test "should destroy system_department" do
    assert_difference('SystemDepartment.count', -1) do
      delete system_department_url(@system_department)
    end

    assert_redirected_to system_departments_url
  end
end
