class FclExwRequestBookingStepsController < ApplicationController
	def request_booking
		if FclExwRequestBookingStep.request_booking(params, current_user)
			shipper = User.find(params[:shipper_id])
			flash[:notice] = "An email has been sent to the shipping company:" + shipper.email + " from " + shipper.company_name
			redirect_to operation_path params[:operation_id]
		end
	end
end
