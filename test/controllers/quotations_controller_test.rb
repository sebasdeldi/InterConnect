require 'test_helper'

class QuotationsControllerTest < ActionDispatch::IntegrationTest
  test "should get request" do
    get quotations_request_url
    assert_response :success
  end

end
