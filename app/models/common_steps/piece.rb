module CommonSteps
	class Piece < ApplicationRecord
	  belongs_to :fcl_exw_steps_cargo_info, optional: true
	end
end
