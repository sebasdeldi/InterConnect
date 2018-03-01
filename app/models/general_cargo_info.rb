class GeneralCargoInfo < ApplicationRecord
	belongs_to :operation
	has_many :pieces
end
