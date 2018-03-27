class OperationsController < ApplicationController

	def show
		@operation = Operation.find params[:id]
		@agent = OperationsByUser.where(operation_id: params[:id]).joins(:agent).first.agent
	end

	# Reserved for admin
	def destroy
	end

end
