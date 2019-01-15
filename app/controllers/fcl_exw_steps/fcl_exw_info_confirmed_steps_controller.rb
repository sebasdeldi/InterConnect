module FclExwSteps	
	class FclExwInfoConfirmedStepsController < ApplicationController
		def confirm_info
			if FclExwSteps::FclExwInfoConfirmedStep.confirm_info(params)
				flash[:notice] = "Step confirmed, no more reminders will be sent"
				redirect_to operation_path params[:operation_id]
			end
		end
	end
end

