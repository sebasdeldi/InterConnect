module FclExwSteps	
	class InfoRequestedController < ApplicationController
		def request_info
			if FclExwSteps::InfoRequested.request_info(params, current_user)
				shipper = User.find(params[:shipper_id])
				flash[:notice] = "An email sent to shipper:" + shipper.email + " from " + shipper.company_name
				redirect_to operation_path params[:operation_id]
			end
		end
	end
end

