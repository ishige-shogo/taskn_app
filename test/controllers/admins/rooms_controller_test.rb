require 'test_helper'

class Admins::RoomsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admins_rooms_index_url
    assert_response :success
  end

  test "should get update" do
    get admins_rooms_update_url
    assert_response :success
  end

end
