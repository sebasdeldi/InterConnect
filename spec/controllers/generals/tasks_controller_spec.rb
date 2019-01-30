require 'rails_helper'

RSpec.describe Generals::TasksController, type: :controller do
	describe "GET show" do
		let(:operation) { create(:operation) }
		let(:task) { create(:task) }

    it "renders show template" do
      get :show, params: { id: task.id }
      expect(response).to render_template("show")
    end
  end

	describe "POST create" do
		let(:operation) { create(:operation) }
		let(:task) { build(:task) }
		let(:fail_task) { build(:fail_task) }

    it "creates new task" do
    	allow(Generals::Task).to receive(:new_task).and_return(task)
      expect {
      	post :create, params: {"task"=>{operation_id: operation.id}}
      }.to change {Generals::Task.count}
      expect(flash[:notice]).to eq("Task saved")   
      expect(response).to redirect_to operation_path operation.id
    end

    it "fails to create new task" do
    	allow(Generals::Task).to receive(:new_task).and_return(fail_task)
      expect {
      	post :create, params: {"task"=>{operation_id: operation.id}}
      }.to_not change {Generals::Task.count}
      expect(flash[:alert]).to eq("Could not save task")   
      expect(response).to redirect_to operation_path operation.id
    end
  end

  describe 'PUT update' do
    let(:operation) { create(:operation) }
    let(:task) { create(:task) }

    it 'redirects to operation with success flash' do
      put :update, params: {id: task.id, "task"=>{operation_id: operation.id, id: task.id, note: "some random note"}}
      expect(flash[:notice]).to eq("Record updated")   
      expect(response).to redirect_to redirect_to operation_path(operation.id)
    end
  end
end
