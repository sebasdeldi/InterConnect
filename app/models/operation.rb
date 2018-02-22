class Operation < ApplicationRecord
	has_many :steps
	has_many :operations_by_users
end
