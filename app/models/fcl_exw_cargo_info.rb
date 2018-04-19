class FclExwCargoInfo < ApplicationRecord
  belongs_to :operation
  validates :loading_address, :container_size, :loading_date, :loading_time, :gross_weight, :commercial_description, :cargo_hazardous, :schedule_b_number, :ein, :pickup_reference, presence: true
end
