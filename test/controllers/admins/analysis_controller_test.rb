require 'test_helper'

class Admins::AnalysisControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admins_analysis_index_url
    assert_response :success
  end

end
