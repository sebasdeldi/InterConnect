module FclExwSteps	
	class InfoConfirmedController < ApplicationController
		def confirm_info
			if FclExwSteps::InfoConfirmed.confirm_info(params)
				flash[:notice] = "Step confirmed, no more reminders will be sent"
				redirect_to operation_path params[:operation_id]
			end
		end
	end
end

