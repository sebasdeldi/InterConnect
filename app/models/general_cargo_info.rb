class GeneralCargoInfo < ApplicationRecord
	belongs_to :operation
	has_many :pieces, dependent: :destroy
	accepts_nested_attributes_for :pieces, allow_destroy: true
	validates :tax_id, :operation_id, :packing_list, :pv_address, :invoice, :pieces_number, presence: true
	validates :pieces_number, numericality: { greater_than: 0}

end
