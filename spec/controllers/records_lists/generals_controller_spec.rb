require 'rails_helper'

RSpec.describe RecordsLists::GeneralsController, type: :controller do
	describe "GET index" do
    it "renders index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "returns list of operations_by_users" do
      get :index
      op = assigns(:operations)
      op.each do |o|
      	expect(o.class).to eq Operations::OperationsByUser
      end
    end
  end
end
