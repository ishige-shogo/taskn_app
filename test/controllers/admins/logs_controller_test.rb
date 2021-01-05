require 'test_helper'

class Admins::LogsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admins_logs_index_url
    assert_response :success
  end

end
