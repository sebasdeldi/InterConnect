module RecordsLists	
	class RepresentativesController < ApplicationController
	  def index
	  	set_sorting_cookies(params[:oldest], params[:newest], params[:more_progress], params[:less_progress])	
	  	set_query_params_cookies(params[:modality], params[:status], params[:search])
			query_params = [cookies[:modality], cookies[:status], cookies[:search]]
			@operations = RecordsLists::Representative.fetch_representative_operations(cookies[:sort_param], query_params, cookies[:representative_id])
	  end
	end
end
