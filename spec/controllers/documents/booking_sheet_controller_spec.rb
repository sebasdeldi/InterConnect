require 'rails_helper'

RSpec.describe Documents::BookingSheetController, type: :controller do
	describe "GET show" do
		let(:operation) { create(:operation) }

    it "renders show template" do
      get :show, params: { operation_id: operation.id }, format: 'pdf'
      expect(response).to render_template("show")
    end
  end
end
