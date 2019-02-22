module LclSteps	
	class RequestBookingsController < ApplicationController
		def request_booking
			if params[:commit] == 'NOTIFY AGENT'
				if LclSteps::RequestBooking.notify(params, current_user)
					flash[:notice] = "An email has been sent to your agent"
					redirect_to operation_path params[:operation_id]
				end 
			else
				LclSteps::RequestBooking.request_booking_website(params[:operation_id], params[:carrier_id])
				flash[:notice] = "Redirecting to the carrier website"
				redirect_to operation_path params[:operation_id]
			end
		end
	end
end
