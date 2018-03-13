class Piece < ApplicationRecord
  belongs_to :general_cargo_information, optional: true
  validates :weight, :height,:width, :depth, :sort, presence: true
end
