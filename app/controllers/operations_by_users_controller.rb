class OperationsByUsersController < ApplicationController

	before_action :authenticate_user!, :require_new_operation_permission, :set_variables
	def new
	end

	def create
		if params[:operations_by_user][:agent_id].present?
			operation = Operation.create(status: 'Defining cargo general information', modality: 'Undefined')
			@operations_by_user = OperationsByUser.create(strong_params.merge(operation_id: operation.id, representative_id: current_user.id))
			flash[:notice] = "Operation successfuly created."
			redirect_to authenticated_root_path, turbolinks: false
		else
			flash[:alert] = "Please choose a valid agent."
			render :new
		end
	end

	private
		def strong_params
			params.require(:operations_by_user).permit(:agent_id)
		end

		def set_variables
			@operations_by_user = OperationsByUser.new
			@agents = User.agents
		end
end
