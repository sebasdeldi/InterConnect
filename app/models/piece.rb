class Piece < ApplicationRecord
  #belongs_to :general_cargo_information, optional: true
  belongs_to :fcl_exw_cargo_info_step, optional: true
end
