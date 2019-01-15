module FclExwSteps
	class FclExwContainerDeliveriesController < ApplicationController
		def confirm_delivery
			if FclExwSteps::FclExwContainerDelivery.confirm_delivery(params, current_user)
				flash[:notice] = "Step confirmed"
				redirect_to operation_path params[:operation_id]
			end
		end
	end
end