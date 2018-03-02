require 'test_helper'

class OperationsByUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get operations_by_users_new_url
    assert_response :success
  end

  test "should get create" do
    get operations_by_users_create_url
    assert_response :success
  end

end
