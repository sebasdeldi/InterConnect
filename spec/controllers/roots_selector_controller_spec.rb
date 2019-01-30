require 'rails_helper'

RSpec.describe RootsSelectorController, type: :controller do
	describe "GET index" do
		let(:representative){ create(:representative) }
		let(:admin){ create(:admin) }
		let(:team_leader){ create(:team_leader) }
		let(:user){ create(:agent) }

    it "renders edit template and redirects to invalid path" do
    	allow(controller).to receive(:current_user) { user }
      get :index
      sign_in(user)
      expect(response).to redirect_to ''
    end

    it "renders edit template and redirects to admin path" do
    	allow(controller).to receive(:current_user) { admin }
      get :index
      sign_in(admin)
      expect(response).to redirect_to users_admin_path
    end

    it "renders edit template and redirects to representative path" do
    	allow(controller).to receive(:current_user) { representative }
      get :index
      sign_in(representative)
      expect(response).to redirect_to users_representative_path
    end

    it "renders edit template and redirects to team leader path" do
    	allow(controller).to receive(:current_user) { team_leader }
      get :index
      sign_in(team_leader)
      expect(response).to redirect_to users_team_path
    end
  end
end
