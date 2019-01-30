require 'rails_helper'

RSpec.describe OperationsController, type: :controller do
	describe "GET show" do
		let(:operation) { create(:operation) }

    it "renders show template" do
      get :show, params: { id: operation.id }
      expect(response).to render_template("show")
    end
  end

  describe 'POST carrier_info' do
    let(:operation) { create(:operation) }
    let(:carrier) { create(:carrier) }

    it "renders json with carriers info" do
      post :carrier_info, params: {"carrier_id"=> carrier.id}
      parse_json = JSON(response.body)
      r =  JSON.parse(response.body).first
      expect(r["company_name"]).to eq(carrier.company_name)
      expect(r["phone_number"]).to eq(carrier.phone_number)
      expect(r["contact_first_name"]).to eq(carrier.contact_first_name)
      expect(r["contact_last_name"]).to eq(carrier.contact_last_name)
      expect(r["company_name"]).to eq(carrier.company_name)
    end
  end

  describe 'PUT change_difficulty' do
    let(:operation) { create(:operation) }
    let(:user) {create(:representative)}

    it "updates operation difficulty" do
    	sign_in(user)
      put :change_difficulty, params: {"operation_id"=> operation.id, "difficulty"=> "HARD"}
      operation.reload
      expect(response).to redirect_to authenticated_root_path
      expect(operation.difficulty).to eq("HARD")
  	end
  end
end
