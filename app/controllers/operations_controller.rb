class OperationsController < ApplicationController

	def show
		@operation = Operation.find params[:id]
	end

	def carrier_info
		@info = User.find(params[:carrier_id])
		render json: @info
	end

	def change_difficulty
		Operation.find(params[:operation_id]).update(difficulty: params[:difficulty])
		redirect_back(fallback_location: authenticated_root_path)
	end

end
