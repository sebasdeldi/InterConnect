require 'rails_helper'

RSpec.describe CommonSteps::InfoConfirmedController, type: :controller do
	describe "POST info_confirmed" do
		let(:operation) { create(:operation) }

    it "confirms info confirmed step" do
    	allow(CommonSteps::InfoConfirmed).to receive(:confirm_info).and_return(true)
      post :confirm_info, params: { operation_id: operation.id }
      expect(flash[:notice]).to eq("Step confirmed")   
			expect(response).to redirect_to operation_path operation.id
    end
  end
end
