require 'rails_helper'

RSpec.describe Documents::InsuranceController, type: :controller do
	describe "GET new" do
		let(:operation) { create(:operation) }

    it "renders new template" do
      get :new, params: { secure_id: operation.secure_id }
      expect(response).to render_template("new")
    end
  end

	describe "GET view_pdf" do
		let(:operation) { create(:operation) }

    it "renders pdf template" do
      get :view_pdf, params: { secure_id: operation.secure_id }, format: 'pdf'
      expect(response).to render_template("view_pdf")
    end
  end

  describe 'POST send_info' do
    let(:operation) { create(:operation) }
    let(:user) { create(:representative) }

    it "redirects to operation path after sending email and flash message" do
    	sign_in(user)
    	copy = double()
    	allow(FclExwOperationMailer).to receive(:send_insurance_info).and_return(copy)
    	allow(copy).to receive(:deliver_later)
      post :send_info, params: {operation_id: operation}
      expect(flash[:notice]).to eq("Email correctly sent")
      expect(response).to redirect_to operation_path(operation)
    end

    it "redirects to unauthenticated root after sending email and flash message" do
    	copy = double()
    	allow(FclExwOperationMailer).to receive(:send_insurance_info).and_return(copy)
    	allow(copy).to receive(:deliver_later)
      post :send_info, params: {operation_id: operation}
      expect(flash[:notice]).to eq("Email correctly sent")
      expect(response).to redirect_to unauthenticated_root_path
    end
  end


  describe 'POST create' do
  	let(:operation) { create(:operation) }
  	let(:user) { create(:representative) }

    it 'redirects to operation with success flash' do
    	create(:insurance, operation_id: operation.id)
    	sign_in(user)
      post :create, params: {"insurance"=>{"operation_id"=> operation.id}}
      expect(flash[:notice]).to eq("Information correctly saved")   
      expect(response).to redirect_to operation_path(operation)
    end

    it 'redirects to unauthenticated root with success flash' do
    	create(:insurance, operation_id: operation.id)
      post :create, params: {"insurance"=>{"operation_id"=> operation.id}}
      expect(flash[:notice]).to eq("Information correctly saved")   
      expect(response).to redirect_to unauthenticated_root_path
    end
  end
end
