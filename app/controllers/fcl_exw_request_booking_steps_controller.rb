class FclExwRequestBookingStepsController < ApplicationController
	def request_booking
		if params[:commit] == 'NOTIFY AGENT'
			if FclExwRequestBookingStep.notify(params, current_user)
				flash[:notice] = "An email has been sent to your agent"
				redirect_to operation_path params[:operation_id]
			end 
		else
			if FclExwRequestBookingStep.request_booking(params, current_user)
				shipper = User.find(params[:shipper_id])
				flash[:notice] = "An email has been sent to the shipping company:" + shipper.email + " from " + shipper.company_name
				redirect_to operation_path params[:operation_id]
			end
		end
	end
end
