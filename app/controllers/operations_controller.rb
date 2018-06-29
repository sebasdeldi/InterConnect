class OperationsController < ApplicationController

	def show
		@operation = Operation.find params[:id]
		@agent = OperationsByUser.where(operation_id: params[:id]).joins(:agent).first.agent
		@shipper = OperationsByUser.where(operation_id: params[:id]).joins(:shipper).first.shipper
		@tasks = Task.where(operation_id: @operation, status: '0')

		@cargo_info_tasks = Task.where(operation_id: @operation, status: '0', fcl_exw_cargo_info_steps_id: FclExwCargoInfoStep.find_by(operation_id: @operation.id))
		@info_confirmed_tasks = Task.where(operation_id: @operation, status: '0', fcl_exw_info_confirmed_steps_id: FclExwInfoConfirmedStep.find_by(operation_id: @operation.id))
		@info_requested_tasks = Task.where(operation_id: @operation, status: '0', fcl_exw_info_requested_steps_id: FclExwInfoRequestedStep.find_by(operation_id: @operation.id))
		@quotation_confirmed_tasks = Task.where(operation_id: @operation, status: '0',fcl_exw_quotation_confirmed_steps_id: FclExwQuotationConfirmedStep.find_by(operation_id: @operation.id))

	end

	# Reserved for admin
	def destroy
	end

end
