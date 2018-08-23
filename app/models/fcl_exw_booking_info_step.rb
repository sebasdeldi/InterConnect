class FclExwBookingInfoStep < ApplicationRecord
	strip_attributes
	belongs_to :operation
	has_many :tasks
end
