class Operation < ApplicationRecord
	before_create :randomize_id
	has_many :operations_by_users
	has_one :invoice
	has_one :insurance
	validates :modality, :pol, :pod, :origin_address, :origin_zip_code, :origin_city, :origin_state, :origin_country, presence: true

	def self.send_fcl_exw_info_confirmation
		operations = Operation.where(fcl_exw_info_requested: true, fcl_exw_info_confirmed: false)
		operations.each do |operation|
			Operations::OperationsByUser.where(operation_id: operation.id).each do |pair|
				FclExwOperationMailer.info_confirmation(pair.shipper, pair.representative, pair.agent).deliver_now
			end
		end
	end

	def self.send_fcl_exw_quotation_confirmation
		operations = Operation.where(fcl_exw_quotation_confirmed: false)
		operations.each do |operation|
			Operations::OperationsByUser.where(operation_id: operation.id).each do |pair|
				FclExwOperationMailer.info_confirmation(pair.shipper, pair.representative, pair.agent).deliver_now
			end
		end
	end

	private
		def randomize_id
		  begin
		    self.secure_id = SecureRandom.random_number(1_000_000)
		  end while Operation.where(secure_id: self.secure_id).exists?
		end
end
