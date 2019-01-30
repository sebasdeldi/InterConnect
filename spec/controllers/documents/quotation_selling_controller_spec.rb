require 'rails_helper'

RSpec.describe Documents::QuotationSellingController, type: :controller do
	describe "GET show" do
		let(:operation) { create(:operation) }

    it "renders show template" do
      get :show, params: { id: operation.id }, format: 'pdf'
      expect(response).to render_template("pdf")
    end
  end

  describe 'POST confirm' do
  	let(:operation) { create(:operation) }
  	let(:representative) { create(:representative) }

    it "requests information to the agent" do
    	sign_in(representative)
    	copy = double()
    	allow(FclExwOperationMailer).to receive(:issue_profit).and_return(copy)
    	allow(copy).to receive(:deliver_later)
      post :confirm, params: { commit: "REQUEST", operation_id: operation.id }
      expect(flash[:notice]).to eq("Information requested to agent")
      expect(response).to redirect_to operation_path(operation.id)
    end

    it "confirms quotation selling step" do
    	sign_in(representative)
    	Documents::QuotationSelling.create(operation_id: operation.id)
    	post :confirm, params: { operation_id: operation.id }
    	expect(flash[:notice]).to eq("Information correctly updated")
    	expect(response).to redirect_to operation_path(operation.id)
    end
  end
end
