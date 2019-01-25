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
end
