require 'rails_helper'

RSpec.describe FclExwSteps::PiecesController, type: :controller do
	describe "POST pieces_for_cargo_info" do
		let(:operation) { create(:operation) }
		let(:cargo_info) { create(:cargo_info) }

    it "retrieves pieces information for a cargo info" do
    	piece = FclExwSteps::Piece.create(fcl_exw_steps_cargo_info_id: cargo_info.id, gross_weight: 123, commercial_description: "some commercial description")
      post :pieces_for_cargo_info, params: { fcl_exw_steps_cargo_info_id: cargo_info.id }
			r =  JSON.parse(response.body).first
			expect(r["fcl_exw_steps_cargo_info_id"]).to eq(cargo_info.id)
			expect(r["gross_weight"]).to eq(123)
			expect(r["commercial_description"]).to eq("some commercial description")
    end
  end
end
