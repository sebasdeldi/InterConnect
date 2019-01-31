require 'rails_helper'

RSpec.describe FclExwSteps::ContainerDeliveriesController, type: :controller do
	describe "POST confirm_delivery" do
		let(:operation) { create(:operation) }

    it "confirms delivery step" do
    	allow(FclExwSteps::ContainerDelivery).to receive(:confirm_delivery).and_return(true)
      post :confirm_delivery, params: { operation_id: operation.id }
      expect(flash[:notice]).to eq("Step confirmed")   
			expect(response).to redirect_to operation_path operation.id
    end
  end
end
