require 'test_helper'

class Users::MainsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_mains_index_url
    assert_response :success
  end

  test "should get edit" do
    get users_mains_edit_url
    assert_response :success
  end

  test "should get update" do
    get users_mains_update_url
    assert_response :success
  end

  test "should get exit" do
    get users_mains_exit_url
    assert_response :success
  end

end
