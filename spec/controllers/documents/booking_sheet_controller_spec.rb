require 'rails_helper'

RSpec.describe Documents::BookingSheetController, type: :controller do
	describe "GET show" do
    it "renders show template" do
    	operation = create(:operation)
      get :show, params: { operation_id: operation.id }, format: 'pdf'
      expect(response).to render_template("show")
    end
  end
end
