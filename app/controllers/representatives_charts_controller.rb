class RepresentativesChartsController < ApplicationController

	def index
		set_sorting_cookies(params[:day], params[:week], params[:month], params[:year])	
		set_query_params_cookies(params[:modality], params[:representative_id])
		@modality_content = cookies[:modality]
		@representative_id = cookies[:representative_id]
		operation = Operation.new
		@operations = operation.fetch_charts(cookies[:date_range_param], @modality_content, nil , @representative_id)
	end

	private
		def set_sorting_cookies(day, week, month, year)
			if day
				cookies.permanent[:date_range_param] = 'day'
			elsif week
				cookies.permanent[:date_range_param] = 'week'
			elsif month
				cookies.permanent[:date_range_param] = 'month'
			elsif year
				cookies.permanent[:date_range_param] = 'year' 
			else 		
				cookies.permanent[:date_range_param] = 'day'
			end
		end

		def set_query_params_cookies(modality, representative_id)
			@modality_content = nil
			@representative_id_content = nil
			cookies.permanent[:modality] = modality
			cookies.permanent[:representative_id] = representative_id
		end
end
