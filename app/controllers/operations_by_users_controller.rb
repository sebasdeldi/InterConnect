class OperationsByUsersController < ApplicationController

	def new
		@operations_by_user = OperationsByUser.new
		@agents = User.agents
	end

	def create
		@agents = User.agents
		operation = Operation.create
		@operations_by_user = OperationsByUser.new(strong_params.merge(operation_id: operation.id))
		if @operations_by_user.save
			OperationsByUser.create(operation_id: operation.id, user_id: current_user.id)
			flash[:notice] = "Operation successfuly created."
			redirect_to authenticated_root_path, turbolinks: false
		else
			flash[:alert] = "Please choose a valid agent."
			render :new
		end
	end

	private
		def strong_params
			params.require(:operations_by_user).permit(:user_id)
		end
end
