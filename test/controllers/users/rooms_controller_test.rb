require 'test_helper'

class Users::RoomsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_rooms_index_url
    assert_response :success
  end

  test "should get show" do
    get users_rooms_show_url
    assert_response :success
  end

  test "should get update" do
    get users_rooms_update_url
    assert_response :success
  end

  test "should get new" do
    get users_rooms_new_url
    assert_response :success
  end

  test "should get create" do
    get users_rooms_create_url
    assert_response :success
  end

end
