require 'test_helper'

class Users::HomesControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get users_homes_top_url
    assert_response :success
  end

  test "should get how_to" do
    get users_homes_how_to_url
    assert_response :success
  end

end
