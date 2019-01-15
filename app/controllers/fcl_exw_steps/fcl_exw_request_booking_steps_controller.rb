module FclExwSteps	
	class FclExwRequestBookingStepsController < ApplicationController
		def request_booking
			if params[:commit] == 'NOTIFY AGENT'
				if FclExwSteps::FclExwRequestBookingStep.notify(params, current_user)
					flash[:notice] = "An email has been sent to your agent"
					redirect_to operation_path params[:operation_id]
				end 
			else
				if params[:website] == "N/A"
					if FclExwSteps::FclExwRequestBookingStep.request_booking(params, current_user)
						shipper = User.find(params[:shipper_id])
						flash[:notice] = "An email has been sent to the shipping company:" + shipper.email + " from " + shipper.company_name
						redirect_to operation_path params[:operation_id]
					end
				else
					FclExwSteps::FclExwRequestBookingStep.request_booking_website(params[:operation_id], params[:carrier_id])
					flash[:notice] = "Redirecting to the carrier website"
					redirect_to operation_path params[:operation_id]
				end
			end
		end
	end
end
