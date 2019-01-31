require 'rails_helper'

RSpec.describe FclExwSteps::BookingInfoController, type: :controller do
	describe "GET new" do
		let(:operation) { create(:operation) }

    it "renders new template" do
      get :new, params: { operation_secure_id: operation.secure_id }
      expect(response).to render_template("new")
    end
  end

	describe "POST create" do
		let(:operation) { create(:operation) }
		let(:booking_info) { create(:booking_info) }

    it "creates new booking info" do
    	allow(FclExwSteps::BookingInfo).to receive(:create_pieces).and_return(true)
    	allow(FclExwSteps::BookingInfo).to receive(:create_tasks).and_return(true)
    	allow(FclExwSteps::BookingInfo).to receive(:save_record).and_return(true)
    	post :create, params: {operation_secure_id: operation.secure_id, fcl_exw_steps_booking_info:{vessel: 'vessel1'}}
      expect(flash[:notice]).to eq("Information correctly updated")   
      expect(response).to redirect_to operation_path operation.id
    end
  end
end
