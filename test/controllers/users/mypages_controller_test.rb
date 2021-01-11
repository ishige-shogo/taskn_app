require 'test_helper'

class Users::MypagesControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get users_mypages_edit_url
    assert_response :success
  end

  test "should get update" do
    get users_mypages_update_url
    assert_response :success
  end

  test "should get unsubscribe" do
    get users_mypages_unsubscribe_url
    assert_response :success
  end

  test "should get withdraw" do
    get users_mypages_withdraw_url
    assert_response :success
  end

end
