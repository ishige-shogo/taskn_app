require 'test_helper'

class Users::MemosControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get users_memos_create_url
    assert_response :success
  end

  test "should get destroy" do
    get users_memos_destroy_url
    assert_response :success
  end

  test "should get destroy_all" do
    get users_memos_destroy_all_url
    assert_response :success
  end

end
