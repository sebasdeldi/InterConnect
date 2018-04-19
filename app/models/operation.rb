class Operation < ApplicationRecord
	has_one :general_cargo_info
	has_many :operations_by_users

	def self.send_fcl_exw_info_confirmation
		operations = Operation.where(fcl_exw_info_requested: true, fcl_exw_info_confirmed: false)
		operations.each do |operation|
			OperationsByUser.where(operation_id: operation.id).each do |pair|
				FclExwOperationMailer.info_confirmation(pair.shipper, pair.representative, pair.agent).deliver_now
			end
		end
	end
end
