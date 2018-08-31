class FclExwQuotationConfirmedStepsController < ApplicationController

	def new
		@operation = Operation.find_by(secure_id: params[:secure_id])
		@quotation = FclExwQuotationConfirmedStep.find_by(operation_id: @operation.id)
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
		puts '======================================================================'
		puts @operation
		puts '======================================================================'
		@quotation = FclExwQuotationConfirmedStep.find_by(operation_id: @operation.id)
		puts '0000000000000000000000000000000000000000000000000000000000000000000000'
		puts params[:files]
		puts '0000000000000000000000000000000000000000000000000000000000000000000000'
		if @quotation.update(files: params[:files])
			flash[:notice] = "Quotation correctly sent"
			redirect_to operation_path(params[:id])
		end
	end

end
