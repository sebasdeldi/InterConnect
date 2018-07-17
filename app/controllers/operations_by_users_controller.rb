class OperationsByUsersController < ApplicationController

	before_action :authenticate_user!, :require_new_operation_permission, :set_variables
	def new
	end

	def create
		if is_representative?
			representative_operation_creation
		elsif is_agent?
			agent_operation_creation
		end
	end

	private
		def set_variables
			@operations_by_user = OperationsByUser.new
			@agents = User.agents
			@shippers = User.shippers
			@representatives = User.representatives
			@consignees = User.consignees
		end

		def representative_operation_creation
			if params[:operations_by_user][:agent_id].present? && params[:operations_by_user][:shipper_id].present?
				fields = [ params[:reference], params[:modality], strong_params_for_representatives, current_user, params[:pieces_number] ]
				@operations_by_user.create_for_representatives(fields)
				set_notice
			else
				set_alert
			end
		end

		def agent_operation_creation
			if params[:operations_by_user][:representative_id].present?
				@operations_by_user.create_for_agents(params[], params[:modality], strong_params_for_agents, current_user)
				set_notice
			else
				set_alert
			end
		end

		def set_notice
			flash[:notice] = "Operation successfuly created."
			cookies.permanent[:redirect_tab] = 'operations_tab'
			redirect_to authenticated_root_path
		end

		def set_alert
			flash[:alert] = "Please choose a valid option."
			render :new
		end

		def strong_params_for_representatives
			params.require(:operations_by_user).permit(:agent_id, :shipper_id, :consignee_id)
		end

		def strong_params_for_agents
			params.require(:operations_by_user).permit(:representative_id)
		end

end
