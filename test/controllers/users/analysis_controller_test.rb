require 'test_helper'

class Users::AnalysisControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_analysis_index_url
    assert_response :success
  end

  test "should get show" do
    get users_analysis_show_url
    assert_response :success
  end

end
