require 'rails_helper'

RSpec.describe Documents::SliController, type: :controller do
	describe "GET show" do
		let(:operation) { create(:operation) }

    it "renders show template" do
      get :show, params: { operation_id: operation.id }, format: 'pdf'
      expect(response).to render_template("sli")
    end
  end

	describe "GET new" do
		let(:operation) { create(:operation) }

    it "renders new template" do
      get :new, params: { secure_id: operation.secure_id }
      expect(response).to render_template("new")
    end
  end

  describe 'POST create' do
    let(:operation) { create(:operation) }
    let(:user) { create(:representative) }

    it "edits existing sli authenticated user" do
    	sign_in(user)
			Documents::Sli.create(operation_id: operation.id)
      post :create, params: {"secure_id"=>operation.secure_id, "sli"=>{operation_id: operation.id}}
      expect(flash[:notice]).to eq("Information correctly saved")   
      expect(response).to redirect_to operation_path(operation.id)
    end

    it "edits existing sli unauthenticated user" do
			Documents::Sli.create(operation_id: operation.id)
      post :create, params: {"secure_id"=>operation.secure_id, "sli"=>{operation_id: operation.id}}
      expect(flash[:notice]).to eq("Information correctly saved")   
      expect(response).to redirect_to unauthenticated_root_path
    end

    it "creates existing sli authenticated user" do
    	sign_in(user)
    	expect {
    		post :create, params: {"secure_id"=>operation.secure_id, "sli"=>{operation_id: operation.id}}
    	}.to change {Documents::Sli.count}
      expect(flash[:notice]).to eq("Information correctly saved")   
      expect(response).to redirect_to operation_path(operation.id)
    end

    it "creates existing sli unauthenticated user" do
    	expect {
    		post :create, params: {"secure_id"=>operation.secure_id, "sli"=>{operation_id: operation.id}}
    	}.to change {Documents::Sli.count}
      expect(flash[:notice]).to eq("Information correctly saved")   
      expect(response).to redirect_to unauthenticated_root_path
    end
  end


  describe 'POST request_sli' do
    let(:operation) { create(:operation) }
    let(:agent) { create(:agent) }
    let(:shipper) { create(:shipper) }
    let(:consignee) { create(:consignee) }
    let(:representative) { create(:representative) }
    let(:op_by_us) { Operations::OperationsByUser.create!(representative_id: representative.id, agent_id: agent.id, operation_id: operation.id, shipper_id: shipper.id, consignee_id: consignee.id)}

    it "redirects to operation path after sending email and flash message" do
      sign_in(representative)
      Operations::OperationsByUser.create!(representative_id: representative.id, agent_id: agent.id, operation_id: operation.id, shipper_id: shipper.id, consignee_id: consignee.id)
      copy = double()
      allow(FclExwOperationMailer).to receive(:request_sli).and_return(copy)
      allow(copy).to receive(:deliver_later)
      post :request_sli, params: { secure_id: operation.secure_id }
      expect(flash[:notice]).to eq("Email correctly sent")
      expect(response).to redirect_to operation_path(operation)
    end

    it "redirects to unauthenticated root path after sending email and flash message" do
      Operations::OperationsByUser.create!(representative_id: representative.id, agent_id: agent.id, operation_id: operation.id, shipper_id: shipper.id, consignee_id: consignee.id)
      copy = double()
      allow(FclExwOperationMailer).to receive(:request_sli).and_return(copy)
      allow(copy).to receive(:deliver_later)
      post :request_sli, params: { secure_id: operation.secure_id }
      expect(flash[:notice]).to eq("Email correctly sent")
      expect(response).to redirect_to unauthenticated_root_path
    end
  end

  describe 'POST tariff_group' do
    let(:operation) { create(:operation) }
    let(:agent) { create(:agent) }
    let(:shipper) { create(:shipper) }
    let(:consignee) { create(:consignee) }
    let(:representative) { create(:representative) }
    let(:op_by_us) { Operations::OperationsByUser.create!(representative_id: representative.id, agent_id: agent.id, operation_id: operation.id, shipper_id: shipper.id, consignee_id: consignee.id)}


    it "redirects to operation path after sending email and flash message" do
      post :tariff_group
      expect(flash[:notice]).to eq("Information correctly saved")
      expect(response).to redirect_to unauthenticated_root_path
    end
  end
end
