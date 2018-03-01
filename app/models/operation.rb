class Operation < ApplicationRecord
	has_one :general_cargo_info
	has_many :operations_by_users
end
