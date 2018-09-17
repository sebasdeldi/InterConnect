class FclExwContainerLoading < ApplicationRecord
	has_many :tasks
	belongs_to :operation
end
