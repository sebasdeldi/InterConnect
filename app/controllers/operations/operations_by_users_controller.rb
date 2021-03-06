module Operations
	class OperationsByUsersController < ApplicationController

		before_action :authenticate_user!, :require_new_operation_permission

		def new
		end

		def create
			op = Operations::OperationsByUser.create_operation_by_representative(params, current_user, strong_params_for_representatives)
			if op[1].empty?
				set_notice
				redirect_to operation_path(op[0].operation_id)
			else
				set_alert(op[1], 'create')
			end
		end

		def edit
			@operation = Operation.find(params[:id])
			@op_by_user = Operations::OperationsByUser.find_by(operation_id: @operation.id)
		end

		def update
			op = Operations::OperationsByUser.update_operation_by_representative(params, current_user, strong_params_for_representatives, params[:operation_id])
			if op[1].empty?
				set_notice
				redirect_to operation_path(op[0].operation_id)
			else
				set_alert(op[1], 'update', params[:id])
			end
		end

		private

			def set_notice
				flash[:notice] = "Operation successfuly created."
				cookies.permanent[:redirect_tab] = 'operations_tab'
			end

			def set_alert(error, method, id=nil)
				flash[:alert] = "Please provide the infomartion marked with (*)"
				if method == 'create'
					redirect_to new_operations_operations_by_user_path(error)
				else
					redirect_to edit_operations_operations_by_user_path(id, error)
				end
			end

			def strong_params_for_representatives
				params.require(:operations_operations_by_user).permit(:agent_id, :shipper_id, :consignee_id)
			end
	end
end