class FclExwInfoConfirmedStep < ApplicationRecord
	has_many :tasks
	belongs_to :operation
end
