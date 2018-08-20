require 'test_helper'

class UsersRelationshipControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get users_relationship_create_url
    assert_response :success
  end

  test "should get destroy" do
    get users_relationship_destroy_url
    assert_response :success
  end

end
