module FclExwQuotationConfirmedStepsHelper
	def quotation(operation)
		FclExwQuotationConfirmedStep.find_by(operation_id: @operation)
	end

	def shipper(operation)
		OperationsByUser.find_by(operation_id: @operation).shipper
	end
end
