require 'test_helper'

class FclExwBookingInfoStepsControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get fcl_exw_booking_infos_update_url
    assert_response :success
  end

end
