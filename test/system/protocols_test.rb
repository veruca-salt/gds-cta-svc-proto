require "application_system_test_case"

class ProtocolsTest < ApplicationSystemTestCase
  setup do
    @protocol = protocols(:one)
  end

  test "visiting the index" do
    visit protocols_url
    assert_selector "h1", text: "Protocols"
  end

  test "creating a Protocol" do
    visit protocols_url
    click_on "New Protocol"

    fill_in "Name", with: @protocol.name
    click_on "Create Protocol"

    assert_text "Protocol was successfully created"
    click_on "Back"
  end

  test "updating a Protocol" do
    visit protocols_url
    click_on "Edit", match: :first

    fill_in "Name", with: @protocol.name
    click_on "Update Protocol"

    assert_text "Protocol was successfully updated"
    click_on "Back"
  end

  test "destroying a Protocol" do
    visit protocols_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Protocol was successfully destroyed"
  end
end
