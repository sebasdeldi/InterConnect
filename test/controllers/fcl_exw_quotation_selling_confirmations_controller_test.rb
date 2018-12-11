require 'test_helper'

class FclExwQuotationSellingConfirmationsControllerTest < ActionDispatch::IntegrationTest
  test "should get confirm" do
    get fcl_exw_quotation_selling_confirmations_confirm_url
    assert_response :success
  end

end
