class GeneralChart
  include OperationQueriable
  include ChartTimeOrganizable

  def self.fetch_general_charts(date_range, modality)

  	all_operations = query_general_charts_operations(set_general_operations, modality)
  	comleted_operations = query_general_charts_operations(set_general_operations.where('operations.status =?', 'COMPLETED'), modality)
  	in_progress_operations = query_general_charts_operations(set_general_operations.where.not('operations.status =?', 'COMPLETED'), modality)

  	charts_info = [
  		set_charts_date_range(all_operations, date_range), 
  		set_charts_date_range(comleted_operations, date_range), 
  		set_charts_date_range(in_progress_operations, date_range) 
  	]
  end

  private
  	def self.query_general_charts_operations(operations, modality)
  		if modality == "ALL"
  			operations
  		else
  			query_by_modality(operations, modality)
  		end
  	end
end
