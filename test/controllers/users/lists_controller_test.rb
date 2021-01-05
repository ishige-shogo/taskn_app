require 'test_helper'

class Users::ListsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get users_lists_new_url
    assert_response :success
  end

  test "should get create" do
    get users_lists_create_url
    assert_response :success
  end

  test "should get destroy" do
    get users_lists_destroy_url
    assert_response :success
  end

  test "should get update" do
    get users_lists_update_url
    assert_response :success
  end

  test "should get start" do
    get users_lists_start_url
    assert_response :success
  end

end
