class FclExwCargoInfo < ApplicationRecord
  belongs_to :operation
  validates :loading_address, :container_size, :loading_datetime, :gross_weight, :commercial_description, :cargo_hazardous, :schedule_b_number, :ein, :pickup_reference, :contact_name, :contact_email, :contact_phone, :contact_company, presence: true
end
