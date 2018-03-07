require 'test_helper'

class GeneralCargoInfosControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get general_cargo_infos_new_url
    assert_response :success
  end

  test "should get create" do
    get general_cargo_infos_create_url
    assert_response :success
  end

end
