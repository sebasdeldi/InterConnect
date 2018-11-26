class OperationsByUsersController < ApplicationController

	before_action :authenticate_user!, :require_new_operation_permission

	def new
	end

	def create
		op = OperationsByUser.create_operation_by_representative(params, current_user, strong_params_for_representatives)
		if op[1].empty?
			set_notice
			redirect_to operation_path(op[0].operation_id)
		else
			set_alert(op[1])
		end
	end

	private

		def set_notice
			flash[:notice] = "Operation successfuly created."
			cookies.permanent[:redirect_tab] = 'operations_tab'
		end

		def set_alert(error)
			flash[:alert] = "Please provide the infomartion marked with (*)"
			redirect_to new_operations_by_user_path(error)
		end

		def strong_params_for_representatives
			params.require(:operations_by_user).permit(:agent_id, :shipper_id, :consignee_id)
		end



=begin
			def agent_operation_creation
				if params[:operations_by_user][:representative_id].present?
					@operations_by_user.create_for_agents(params[], params[:modality], strong_params_for_agents, current_user)
					set_notice
				else
					set_alert
				end
			end
=end
		
		#def strong_params_for_agents
			#params.require(:operations_by_user).permit(:representative_id)
		#end

end
