class OperationsController < ApplicationController

	def show
		@operation = Operation.find params[:id]
		@agent = OperationsByUser.where(operation_id: params[:id]).joins(:agent).first.agent
		@shipper = OperationsByUser.where(operation_id: params[:id]).joins(:shipper).first.shipper
	end

	# Reserved for admin
	def destroy
	end

end
