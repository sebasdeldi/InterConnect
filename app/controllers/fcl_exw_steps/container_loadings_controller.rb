module FclExwSteps	
	class ContainerLoadingsController < ApplicationController
		def confirm_loading
			if FclExwSteps::ContainerLoading.confirm_loading(params, current_user)
				flash[:notice] = "Step confirmed"
				redirect_to operation_path params[:operation_id]
			end
		end
	end
end