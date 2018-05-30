class GeneralChartsController < ApplicationController

	def index
		set_date_range_cookies(params[:day], params[:week], params[:month], params[:year])	
		set_query_params_cookies(params[:modality], params[:search])
		@modality_content = cookies[:modality]
		@search_content = cookies[:search]
		operation = Operation.new
		@operations = operation.fetch_charts(cookies[:date_range_param], @modality_content, @search_content)
	end

	private
		def set_query_params_cookies(modality, search)
			@modality_content = nil
			@search_content = nil
			cookies.permanent[:modality] = modality
			cookies.permanent[:search] = search
		end
end
