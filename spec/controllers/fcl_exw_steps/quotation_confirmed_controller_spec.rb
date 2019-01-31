require 'rails_helper'

RSpec.describe FclExwSteps::QuotationConfirmedController, type: :controller do
	describe "GET new" do
		let(:operation) { create(:operation) }

    it "renders new template" do
      get :new, params: { secure_id: operation.secure_id }
      expect(response).to render_template("new")
    end
  end

  describe 'POST confirm_quotation' do
    let(:operation) { create(:operation) }
    let(:user) {create(:representative)}

    it "confirms quotation succesfully" do
    	sign_in(user)
    	allow(FclExwSteps::QuotationConfirmed).to receive(:confirm_quotation).and_return('success')
      post :confirm_quotation, params: {"commit"=> "ISSUE", operation_id: operation.id}
      expect(flash[:notice]).to eq("success")   
      expect(response).to redirect_to operation_path operation.id
  	end

	  it "confirms quotation fails" do
	  	sign_in(user)
	  	allow(FclExwSteps::QuotationConfirmed).to receive(:confirm_quotation).and_return('fail')
	    post :confirm_quotation, params: {"commit"=> "xxxx", operation_id: operation.id}
	    expect(flash[:alert]).to eq("fail")   
	    expect(response).to redirect_to operation_path operation.id
		end
  end

  describe 'POST update_pricing' do
    let(:operation) { create(:operation) }
    let(:user) {create(:representative)}

    it "confirms quotation by pricing succesfully" do
    	sign_in(user)
    	FclExwSteps::QuotationConfirmed.create(operation_id: operation.id)
      post :update_pricing, params: {secure_id: operation.secure_id}
      expect(flash[:notice]).to eq("Quotation correctly sent")   
      expect(response).to redirect_to fcl_exw_steps_new_quotation_view_path(operation.secure_id)
  	end
  end
end
