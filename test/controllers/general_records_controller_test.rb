require 'test_helper'

class GeneralRecordsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get general_records_index_url
    assert_response :success
  end

end
