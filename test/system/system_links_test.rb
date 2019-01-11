require "application_system_test_case"

class SystemLinksTest < ApplicationSystemTestCase
  setup do
    @system_link = system_links(:one)
  end

  test "visiting the index" do
    visit system_links_url
    assert_selector "h1", text: "System Links"
  end

  test "creating a System link" do
    visit system_links_url
    click_on "New System Link"

    fill_in "Protocol", with: @system_link.protocol
    fill_in "System a", with: @system_link.system_a_id
    fill_in "System b", with: @system_link.system_b_id
    fill_in "Weight", with: @system_link.weight
    click_on "Create System link"

    assert_text "System link was successfully created"
    click_on "Back"
  end

  test "updating a System link" do
    visit system_links_url
    click_on "Edit", match: :first

    fill_in "Protocol", with: @system_link.protocol
    fill_in "System a", with: @system_link.system_a_id
    fill_in "System b", with: @system_link.system_b_id
    fill_in "Weight", with: @system_link.weight
    click_on "Update System link"

    assert_text "System link was successfully updated"
    click_on "Back"
  end

  test "destroying a System link" do
    visit system_links_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "System link was successfully destroyed"
  end
end
