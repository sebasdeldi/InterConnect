require 'rails_helper'

RSpec.describe Documents::InvoiceController, type: :controller do
	describe "GET new" do
		let(:operation) { create(:operation) }

    it "renders new template" do
      get :new, params: { secure_id: operation.secure_id }
      expect(response).to render_template("new")
    end
  end

	describe 'POST request_invoice' do
		let(:operation) { create(:operation) }
		let(:agent) { create(:agent) }
		let(:shipper) { create(:shipper) }
		let(:consignee) { create(:consignee) }
		let(:representative) { create(:representative) }
		let(:op_by_us) { Operations::OperationsByUser.create!(representative_id: representative.id, agent_id: agent.id, operation_id: operation.id, shipper_id: shipper.id, consignee_id: consignee.id)}

	  it "redirects to operation path after sending email and flash message" do
	  	op_by_us
	  	sign_in(representative)
	  	copy = double()
	  	allow(FclExwOperationMailer).to receive(:request_invoice).and_return(copy)
	  	allow(copy).to receive(:deliver_later)
	    post :request_invoice, params: { secure_id: operation.secure_id }
	    expect(flash[:notice]).to eq("Email correctly sent")
	    expect(response).to redirect_to operation_path(operation)
	  end
	end

	describe 'POST create' do
		let(:operation) { create(:operation) }
		let(:user) { create(:representative) }
		let(:invoice) { Documents::Invoice.create(operation_id: operation.id) }

	  it 'redirects to operation with success flash and updates' do
	  	invoice
	  	sign_in(user)
	    post :create, params: {"secure_id"=> operation.secure_id, "invoice"=>{ "operation_id"=>operation.id} }
	    expect(flash[:notice]).to eq("Information correctly saved")   
	    expect(response).to redirect_to operation_path(operation)
	  end

	  it 'redirects to operation with success flash and creates' do
	  	sign_in(user)
	    post :create, params: {"secure_id"=> operation.secure_id, "invoice"=>{ "operation_id"=>operation.id} }
	    expect(flash[:notice]).to eq("Information correctly saved")   
	    expect(response).to redirect_to operation_path(operation)
	  end
	end

end
