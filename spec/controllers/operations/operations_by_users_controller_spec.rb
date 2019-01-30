require 'rails_helper'

RSpec.describe Operations::OperationsByUsersController, type: :controller do
	describe "GET new" do
    context 'logged in' do
      it "renders new template" do
        allow(controller).to receive(:authenticate_user!).and_return(true)
        allow(controller).to receive(:require_new_operation_permission).and_return(true)
        get :new
        expect(response).to render_template("new")
      end
    end

    context 'not logged in' do
      it "redirects to login" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET edit' do
    let(:operation) { create(:operation) }
    it "renders edit template" do
      allow(controller).to receive(:authenticate_user!).and_return(true)
      allow(controller).to receive(:require_new_operation_permission).and_return(true)
      get :edit, params: { id: operation.id }
      expect(response).to render_template("edit")
    end
  end

  describe 'PUT update' do
    let(:operation) { create(:operation) }
    let(:agent) { create(:agent) }
    let(:shipper) { create(:shipper) }
    let(:consignee) { create(:consignee) }
    let(:operation_by_user) { Operations::OperationsByUser.create(agent_id: agent.id, operation_id: operation.id, shipper_id: shipper.id, consignee_id: consignee.id) }

    it "redirects to edit with fail flash" do
      #skipping validations
      allow(controller).to receive(:authenticate_user!).and_return(true)
      allow(controller).to receive(:require_new_operation_permission).and_return(true)

      allow(Operations::OperationsByUser).to receive(:update_operation_by_representative).and_return(['xxx',['error']])
      put :update, params: {"id"=>operation.id, "operations_operations_by_user"=>{"agent_id"=>"158", "shipper_id"=>"159", "consignee_id"=>"160"}}
      expect(flash[:alert]).to eq("Please provide the infomartion marked with (*)")   
      expect(response).to redirect_to edit_operations_operations_by_user_path(operation.id, 'error')
    end

    it 'redirects to operation with success flash' do
      #skipping validations
      allow(controller).to receive(:authenticate_user!).and_return(true)
      allow(controller).to receive(:require_new_operation_permission).and_return(true)

      allow(Operations::OperationsByUser).to receive(:update_operation_by_representative).and_return([operation_by_user, []])
      put :update, params: {"id"=>operation_by_user.operation_id, "operations_operations_by_user"=>{"agent_id"=>"158", "shipper_id"=>"159", "consignee_id"=>"160"}}
      expect(flash[:notice]).to eq("Operation successfuly created.")   
      expect(response).to redirect_to operation_path(operation_by_user.operation_id)
    end
  end


  describe 'POST create' do
    let(:operation) { create(:operation) }
    let(:agent) { create(:agent) }
    let(:shipper) { create(:shipper) }
    let(:consignee) { create(:consignee) }
    let(:operation_by_user) { Operations::OperationsByUser.create(agent_id: agent.id, operation_id: operation.id, shipper_id: shipper.id, consignee_id: consignee.id) }

    it "redirects to edit with fail flash" do
      #skipping validations
      allow(controller).to receive(:authenticate_user!).and_return(true)
      allow(controller).to receive(:require_new_operation_permission).and_return(true)

      allow(Operations::OperationsByUser).to receive(:create_operation_by_representative).and_return(['xxx',['error']])
      post :create, params: {"id"=>operation.id, "operations_operations_by_user"=>{"agent_id"=>"158", "shipper_id"=>"159", "consignee_id"=>"160"}}
      expect(flash[:alert]).to eq("Please provide the infomartion marked with (*)")   
      expect(response).to redirect_to new_operations_operations_by_user_path('error')
    end

    it 'redirects to operation with success flash' do
      #skipping validations
      allow(controller).to receive(:authenticate_user!).and_return(true)
      allow(controller).to receive(:require_new_operation_permission).and_return(true)

      allow(Operations::OperationsByUser).to receive(:create_operation_by_representative).and_return([operation_by_user, []])
      post :create, params: {"id"=>operation_by_user.operation_id, "operations_operations_by_user"=>{"agent_id"=>"158", "shipper_id"=>"159", "consignee_id"=>"160"}}
      expect(flash[:notice]).to eq("Operation successfuly created.")   
      expect(response).to redirect_to redirect_to operation_path(operation_by_user.operation_id)
    end
  end
end
