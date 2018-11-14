class FclExwContainerLoadingsController < ApplicationController
	def confirm_loading
		if FclExwContainerLoading.confirm_loading(params, current_user)
			flash[:notice] = "Step confirmed"
			redirect_to operation_path params[:operation_id]
		end
	end
end