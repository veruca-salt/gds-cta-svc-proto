require "application_system_test_case"

class SystemDepartmentsTest < ApplicationSystemTestCase
  setup do
    @system_department = system_departments(:one)
  end

  test "visiting the index" do
    visit system_departments_url
    assert_selector "h1", text: "System Departments"
  end

  test "creating a System department" do
    visit system_departments_url
    click_on "New System Department"

    fill_in "Department", with: @system_department.department_id
    fill_in "System", with: @system_department.system_id
    click_on "Create System department"

    assert_text "System department was successfully created"
    click_on "Back"
  end

  test "updating a System department" do
    visit system_departments_url
    click_on "Edit", match: :first

    fill_in "Department", with: @system_department.department_id
    fill_in "System", with: @system_department.system_id
    click_on "Update System department"

    assert_text "System department was successfully updated"
    click_on "Back"
  end

  test "destroying a System department" do
    visit system_departments_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "System department was successfully destroyed"
  end
end
