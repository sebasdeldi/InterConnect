require 'rails_helper'

RSpec.describe FclExwSteps::InfoRequestedController, type: :controller do
	describe "POST request_info" do
		let(:operation) { create(:operation) }
		let(:shipper) { create(:shipper) }

    it "confirms request info step" do
    	allow(FclExwSteps::InfoRequested).to receive(:request_info).and_return(true)
      post :request_info, params: { operation_id: operation.id, shipper_id: shipper.id }
      expect(flash[:notice]).to eq("An email sent to shipper:" + shipper.email + " from " + shipper.company_name)   
			expect(response).to redirect_to operation_path operation.id
    end
  end
end
