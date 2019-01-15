class Piece < ApplicationRecord
  #belongs_to :general_cargo_information, optional: true
  belongs_to :fcl_exw_steps_cargo_info, optional: true
end
