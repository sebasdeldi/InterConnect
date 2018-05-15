class RepresentativesChartsController < ApplicationController

	def index
		set_sorting_cookies(params[:day], params[:week], params[:month], params[:year])	
		set_query_params_cookies(params[:modality], params[:search])
		@modality_content = cookies[:modality]
		@search_content = cookies[:search]
		operation = Operation.new
		@operations_by_user = operation.fetch_charts(cookies[:sort_param], @modality_content, @search_content)
	end

	private
		def set_sorting_cookies(day, week, month, year)
			if day
				cookies.permanent[:sort_param] = 'day'
			elsif week
				cookies.permanent[:sort_param] = 'week'
			elsif month
				cookies.permanent[:sort_param] = 'month'
			elsif year
				cookies.permanent[:sort_param] = 'year'  			
			end
		end

		def set_query_params_cookies(modality, search)
			@modality_content = nil
			@search_content = nil
			cookies.permanent[:modality] = modality
			cookies.permanent[:search] = search
		end
end
