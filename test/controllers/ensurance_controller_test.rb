require 'test_helper'

class EnsuranceControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get ensurance_new_url
    assert_response :success
  end

  test "should get view_pdf" do
    get ensurance_view_pdf_url
    assert_response :success
  end

  test "should get create" do
    get ensurance_create_url
    assert_response :success
  end

end
