require 'test_helper'

class Users::ContactsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_contacts_index_url
    assert_response :success
  end

  test "should get new" do
    get users_contacts_new_url
    assert_response :success
  end

  test "should get create" do
    get users_contacts_create_url
    assert_response :success
  end

end
