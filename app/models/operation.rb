class Operation < ApplicationRecord
	before_create :randomize_id
	has_many :operations_by_users
	has_one :invoice
	has_one :insurance
	validates :modality, :pol, :pod, :origin_address, :origin_zip_code, :origin_city, :origin_state, :origin_country, presence: true

	private
		def randomize_id
		  begin
		    self.secure_id = SecureRandom.random_number(1_000_000)
		  end while Operation.where(secure_id: self.secure_id).exists?
		end
end
