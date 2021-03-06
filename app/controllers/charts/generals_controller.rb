module Charts	
	class GeneralsController < ApplicationController
		def index
			set_date_range_cookies(params[:day], params[:week], params[:month], params[:year])	
			set_query_params_cookies(params[:modality])
			@modality_content = cookies[:modality]
			@operations = Charts::General.fetch_general_charts(cookies[:date_range_param], @modality_content)
		end

		private
			def set_query_params_cookies(modality)
				if modality.nil?
					cookies.permanent[:modality] = 'ALL'
				else
					cookies.permanent[:modality] = modality
				end
			end
	end
end