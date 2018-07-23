class FclExwRequestBookingStep < ApplicationRecord
	has_many :tasks
	belongs_to :operation
end
