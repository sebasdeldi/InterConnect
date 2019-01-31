require 'rails_helper'

RSpec.describe FclExwSteps::CargoInfoController, type: :controller do
	describe "GET new" do
		let(:operation) { create(:operation) }

    it "renders new template" do
      get :new, params: { operation_secure_id: operation.secure_id }
      expect(response).to render_template("new")
    end
  end

	describe "POST create" do
		let(:operation) { create(:operation) }
		let(:cargo_info) { create(:cargo_info) }
		let(:representative) { create(:representative) }

    it "updates cargo info by representative" do
    	sign_in(representative)
    	allow(controller).to receive(:current_user) { representative }
    	allow(FclExwSteps::CargoInfo).to receive(:create_cargo_info).and_return(true)
    	post :create, params: {operation_secure_id: operation.secure_id, fcl_exw_steps_cargo_info:{loading_address: 'loading address'}}
      expect(flash[:notice]).to eq("Information correctly updated")   
      expect(response).to redirect_to operation_path operation.id
    end

    it "updates cargo info by agent" do
    	allow(FclExwSteps::CargoInfo).to receive(:create_cargo_info).and_return(true)
    	post :create, params: {operation_secure_id: operation.secure_id, fcl_exw_steps_cargo_info:{loading_address: 'loading address'}}
      expect(flash[:notice]).to eq("Information correctly updated")   
      expect(response).to redirect_to unauthenticated_root_path
    end
  end
end
