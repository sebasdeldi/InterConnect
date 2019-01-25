require 'rails_helper'

RSpec.describe Charts::RepresentativesController, type: :controller do
	describe "GET index" do
    it "renders index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "populates array of operations by date hashes" do
      get :index
      op = assigns(:operations)
      expect(op.class).to eq Array
      expect(op.length).to eq 3 
      expect(op[0].class).to eq Hash 
      expect(op[1].class).to eq Hash 
      expect(op[2].class).to eq Hash 
    end
  end
end
