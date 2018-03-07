class Piece < ApplicationRecord
  belongs_to :general_cargo_information, optional: true
end
