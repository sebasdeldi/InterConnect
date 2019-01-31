require 'rails_helper'

RSpec.describe FclExwSteps::RequestBookingsController, type: :controller do
  describe 'POST request_booking' do
    let(:operation) { create(:operation) }
    let(:user) {create(:representative)}
    let(:shipper) {create(:shipper)}

    it "notifies agent" do
    	sign_in(user)
    	allow(FclExwSteps::RequestBooking).to receive(:notify).and_return(true)
      post :request_booking, params: {commit: "NOTIFY AGENT", operation_id: operation.id}
      expect(flash[:notice]).to eq("An email has been sent to your agent")   
      expect(response).to redirect_to operation_path operation.id
  	end

	  it "redirects to carrier website" do
	  	sign_in(user)
	  	allow(FclExwSteps::RequestBooking).to receive(:request_booking_website).and_return(true)
	    post :request_booking, params: {website: "hapag.com", operation_id: operation.id}
	    expect(flash[:notice]).to eq("Redirecting to the carrier website")   
	    expect(response).to redirect_to operation_path operation.id
		end

	  it "sends booking request via email" do
	  	sign_in(user)
	  	allow(FclExwSteps::RequestBooking).to receive(:request_booking).and_return(true)
	    post :request_booking, params: {website: "N/A", operation_id: operation.id, shipper_id: shipper.id}
	    expect(flash[:notice]).to eq("An email has been sent to the shipping company:" + shipper.email + " from " + shipper.company_name)   
	    expect(response).to redirect_to operation_path operation.id
		end
  end
end
