require 'test_helper'

class SystemLinksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @system_link = system_links(:one)
  end

  test "should get index" do
    get system_links_url
    assert_response :success
  end

  test "should get new" do
    get new_system_link_url
    assert_response :success
  end

  test "should create system_link" do
    assert_difference('SystemLink.count') do
      post system_links_url, params: { system_link: { protocol: @system_link.protocol, system_a_id: @system_link.system_a_id, system_b_id: @system_link.system_b_id, weight: @system_link.weight } }
    end

    assert_redirected_to system_link_url(SystemLink.last)
  end

  test "should show system_link" do
    get system_link_url(@system_link)
    assert_response :success
  end

  test "should get edit" do
    get edit_system_link_url(@system_link)
    assert_response :success
  end

  test "should update system_link" do
    patch system_link_url(@system_link), params: { system_link: { protocol: @system_link.protocol, system_a_id: @system_link.system_a_id, system_b_id: @system_link.system_b_id, weight: @system_link.weight } }
    assert_redirected_to system_link_url(@system_link)
  end

  test "should destroy system_link" do
    assert_difference('SystemLink.count', -1) do
      delete system_link_url(@system_link)
    end

    assert_redirected_to system_links_url
  end
end
