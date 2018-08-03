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
				if Operation.last.nil?
					reference = (current_user.contact_first_name[0..0] + current_user.contact_last_name[0..0] + "1").upcase
				else
					reference = (current_user.contact_first_name[0..0] + current_user.contact_last_name[0..0] + (Operation.last.id + 1).to_s).upcase
				end
				fields = [ reference, params[:modality], strong_params_for_representatives, current_user, params[:pieces_number] ]
				new_operation = @operations_by_user.create_for_representatives(fields)
				set_notice
				redirect_to operation_path(new_operation)
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
