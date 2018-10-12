require 'test_helper'

class SliControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get sli_show_url
    assert_response :success
  end

end
