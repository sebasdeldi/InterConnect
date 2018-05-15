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
			@shippers = User.shippers
			@representatives = User.representatives
		end

		def create_for_representatives

			if params[:operations_by_user][:agent_id].present? && params[:operations_by_user][:shipper_id].present?
				operation = create_operation(params[:modality])
				@operations_by_user = OperationsByUser.create(strong_params_for_representatives.merge(operation_id: operation.id, representative_id: current_user.id))
				flash[:notice] = "Operation successfuly created."
				redirect_to authenticated_root_path
			else
				flash[:alert] = "Please choose a valid agent and shipper."
				render :new
			end
		end

		def create_operation(modality)
			steps_number = 1
			if modality == "FCL - EXW"
				steps_number = 4
				#TODO add other modality cases
			end
			operation = Operation.create(status: 'In Progress: Initializing operation', modality: modality, steps_number: steps_number, current_step: 0)
		end

		def create_for_agents
			if params[:operations_by_user][:representative_id].present?
				operation = Operation.create(status: 'In Progress: Initializing operation', modality: params[:modality])
				@operations_by_user = OperationsByUser.create(strong_params_for_agents.merge(operation_id: operation.id, agent_id: current_user.id))
				flash[:notice] = "Operation successfuly created."
				redirect_to authenticated_root_path
			else
				flash[:alert] = "Please choose a valid agent."
				render :new
			end
		end

		def strong_params_for_representatives
			params.require(:operations_by_user).permit(:agent_id, :shipper_id)
		end

		def strong_params_for_agents
			params.require(:operations_by_user).permit(:representative_id)
		end

end
