class GeneralCargoInfo < ApplicationRecord
	belongs_to :operation
	has_many :pieces, dependent: :destroy
	accepts_nested_attributes_for :pieces, allow_destroy: true
end
