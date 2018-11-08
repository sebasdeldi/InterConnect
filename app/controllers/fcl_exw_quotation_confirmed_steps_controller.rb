class FclExwQuotationConfirmedStepsController < ApplicationController

	def new
		@operation = Operation.find_by(secure_id: params[:secure_id])
		@quotation = FclExwQuotationConfirmedStep.find_by(operation_id: @operation.id)
		@shipper = OperationsByUser.find_by(operation_id: @operation.id).shipper
	end

	def update_pricing
		@operation = Operation.find_by(secure_id: params[:secure_id])
		@quotation = FclExwQuotationConfirmedStep.find_by(operation_id: @operation.id)
		if @quotation.update(files: params[:files])
			flash[:notice] = "Quotation correctly sent"
			redirect_to new_quotation_view_path(params[:secure_id])
		end
	end

	def update_representative
		@operation = Operation.find(params[:id])
		@quotation = FclExwQuotationConfirmedStep.find_by(operation_id: @operation.id)
		if @quotation.update(files: params[:files])
			flash[:notice] = "Quotation correctly sent"
			redirect_to operation_path(params[:id])
		end
	end

end
