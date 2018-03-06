class OperationsByUsersController < ApplicationController

	before_action :authenticate_user!, :require_new_operation_permission, :set_variables
	def new
	end

	def create
		if is_representative?
			create_for_representatives
		elsif is_agent?
			create_for_agents
		end
	end

	private
		def set_variables
			@operations_by_user = OperationsByUser.new
			@agents = User.agents
			@representatives = User.representatives
		end

		def create_for_representatives
			if params[:operations_by_user][:agent_id].present?
				operation = Operation.create(status: 'Defining cargo general information', modality: 'Undefined')
				@operations_by_user = OperationsByUser.create(strong_params_for_representatives.merge(operation_id: operation.id, representative_id: current_user.id))
				flash[:notice] = "Operation successfuly created."
				redirect_to authenticated_root_path, turbolinks: false
			else
				flash[:alert] = "Please choose a valid agent."
				render :new
			end
		end

		def create_for_agents
			if params[:operations_by_user][:representative_id].present?
				operation = Operation.create(status: 'Defining cargo general information', modality: 'Undefined')
				@operations_by_user = OperationsByUser.create(strong_params_for_agents.merge(operation_id: operation.id, agent_id: current_user.id))
				flash[:notice] = "Operation successfuly created."
				redirect_to authenticated_root_path, turbolinks: false
			else
				flash[:alert] = "Please choose a valid agent."
				render :new
			end
		end

		def strong_params_for_representatives
			params.require(:operations_by_user).permit(:agent_id)
		end

		def strong_params_for_agents
			params.require(:operations_by_user).permit(:representative_id)
		end

end
