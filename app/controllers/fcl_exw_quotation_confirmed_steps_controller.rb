class FclExwQuotationConfirmedStepsController < ApplicationController
	def new
		@operation = Operation.find_by(secure_id: params[:secure_id])
	end

	def update_pricing
		operation = Operation.find_by(secure_id: params[:secure_id])
		quotation = FclExwQuotationConfirmedStep.find_by(operation_id: operation)
		if quotation.update(files: params[:files])
			flash[:notice] = "Quotation correctly sent"
			redirect_to new_quotation_view_path(params[:secure_id])
		end
	end

	def update_representative
		operation = Operation.find(params[:id])
		quotation = FclExwQuotationConfirmedStep.find_by(operation_id: operation)
		if quotation.update(files: params[:files])
			flash[:notice] = "Quotation correctly sent"
			redirect_to operation_path(params[:id])
		end
	end

	def confirm_quotation
		confirmation = FclExwQuotationConfirmedStep.confirm_quotation(params, current_user)
		if params[:files].present? || params[:commit] == 'ISSUE'
			flash[:notice] = confirmation
		else
			flash[:alert] = confirmation
		end
		redirect_to operation_path params[:operation_id]
	end

end
