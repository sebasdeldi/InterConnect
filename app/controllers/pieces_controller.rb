class PiecesController < ApplicationController

	def pieces_for_cargo_info
		pieces = Piece.where(fcl_exw_steps_cargo_info_id: params[:fcl_exw_steps_cargo_info_id]).to_a
		unless pieces.empty?
			pieces << 'update'
		end
		render json: pieces 
	end
end
