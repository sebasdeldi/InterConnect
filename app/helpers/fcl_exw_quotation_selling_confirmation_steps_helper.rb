module FclExwQuotationSellingConfirmationStepsHelper
	def quotation_confirmation_price(operation_id)
		FclExwQuotationSellingConfirmationStep.find_by(operation_id: operation_id)
	end

	def quotation_total(quotation)
		profit = quotation.profit.nil? ? 0 : quotation.profit
		documentation = quotation.documentation.nil? ? 0 : quotation.documentation
		ff = quotation.ff.nil? ? 0 : quotation.ff
		vgm = quotation.vgm.nil? ? 0 : quotation.vgm 
		inland = quotation.inland.nil? ? 0 : quotation.inland 
		others = quotation.others.nil? ? 0 : quotation.others
		profit + documentation + ff + vgm + inland + others
	end
end
