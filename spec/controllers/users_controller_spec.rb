require 'rails_helper'

RSpec.describe UsersController, type: :controller do
	describe "GET edit" do
		let(:agent){ create(:agent) }

    it "renders edit template" do
      get :edit, params: { id: agent.id, role_id: agent.role_id }
      expect(response).to render_template("edit")
    end
  end

  describe 'PUT update' do
		let(:agent){ create(:agent) }

    it "updates operation difficulty" do
    	sign_in(agent)
      put :update, params: {"id"=> agent.id, 'user'=>{"company_name"=> "New name"}}
      agent.reload
      expect(response).to redirect_to authenticated_root_path
      expect(agent.company_name).to eq("New name")
      expect(flash[:notice]).to eq("Information Updated")
  	end
  end
end
