class OperationsController < ApplicationController

	def show
		@operation = Operation.find params[:id]
	end

	def carrier_info
		company_name = User.find(params[:carrier_id]).company_name
		@info = User.where(company_name: company_name)
		render json: @info
	end

	def change_difficulty
		Operation.find(params[:operation_id]).update(difficulty: params[:difficulty])
		redirect_back(fallback_location: authenticated_root_path)
	end
end
