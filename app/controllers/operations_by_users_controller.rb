class OperationsByUsersController < ApplicationController

	before_action :authenticate_user!, :require_new_operation_permission

	def new
		@operations_by_user = OperationsByUser.new
	end

	def create
		op = OperationsByUser.create_operation_by_representative(params, current_user, strong_params_for_representatives)
		if op
			set_notice
			redirect_to operation_path(op)
		else
			set_alert
		end
	end

	private

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
