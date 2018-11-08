class RepresentativesChartsController < ApplicationController

	def index
		set_date_range_cookies(params[:day], params[:week], params[:month], params[:year])	
		set_query_params_cookies(params[:modality], params[:representative_id])
		@modality_content = cookies[:modality]
		@representative_id = cookies[:representative_id]
		@operations = RepresentativeChart.fetch_representatives_charts(cookies[:date_range_param], @modality_content , @representative_id)
	end

	private
		def set_query_params_cookies(modality, representative_id)
			@modality_content = nil
			@representative_id_content = nil
			cookies.permanent[:modality] = modality
			cookies.permanent[:representative_id] = representative_id
		end
end
