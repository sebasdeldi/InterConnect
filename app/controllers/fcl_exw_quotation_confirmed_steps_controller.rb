class FclExwQuotationConfirmedStepsController < ApplicationController

	def new
		@operation = Operation.find_by(secure_id: params[:secure_id])
		@quotation = FclExwQuotationConfirmedStep.find_by(operation_id: @operation.id)
	end

	def update_pricing
		@operation = Operation.find_by(secure_id: params[:secure_id])
		@quotation = FclExwQuotationConfirmedStep.find_by(operation_id: @operation.id)
		if @quotation.update(additional_comment: params[:additional_comment], neta: params[:neta], venta: params[:venta])
			flash[:notice] = "Quotation correctly sent"
			redirect_to new_quotation_view_path(params[:secure_id])
		end
	end

	def update_representative
		@operation = Operation.find(params[:id])
		@quotation = FclExwQuotationConfirmedStep.find_by(operation_id: @operation.id)
		if @quotation.update(additional_comment: params[:additional_comment], neta: params[:neta], venta: params[:venta])
			flash[:notice] = "Quotation correctly sent"
			redirect_to operation_path(params[:id])
		end
	end

end
