class FclExwInfoConfirmedStepsController < ApplicationController
	def confirm_info
		if FclExwInfoConfirmedStep.confirm_info(params)
			flash[:notice] = "Step confirmed, no more reminders will be sent"
			redirect_to operation_path params[:operation_id]
		end
	end
end

