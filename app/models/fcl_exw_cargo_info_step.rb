class FclExwCargoInfoStep < ApplicationRecord
	strip_attributes
  belongs_to :operation
  has_many :tasks
  has_many :pieces, dependent: :destroy
	accepts_nested_attributes_for :pieces, allow_destroy: true
	#validates :pieces_number, numericality: { greater_than: 0, less_than: 50}
  #validates :loading_address, :container_size, :loading_date, :loading_time, :gross_weight, :commercial_description, :cargo_hazardous, :schedule_b_number, :ein, :pickup_reference, presence: true
end
