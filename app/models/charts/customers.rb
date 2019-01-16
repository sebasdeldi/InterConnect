module Charts
  class Customers
    include OperationQueriable
    include ChartTimeOrganizable

    def self.fetch_customers_charts(date_range, modality, customer_id)
    	modality = modality == 'ALL' ? nil : modality

    	all_operations = query_customers_charts_operations(set_general_operations, date_range, modality, customer_id)
    	comleted_operations = query_customers_charts_operations(set_general_operations.where('operations.status =?', 'COMPLETED'), date_range, modality, customer_id)
    	in_progress_operations = query_customers_charts_operations(set_general_operations.where.not('operations.status =?', 'COMPLETED'), date_range, modality, customer_id)

    	charts_info = [
    		set_charts_date_range(all_operations, date_range), 
    		set_charts_date_range(comleted_operations, date_range), 
    		set_charts_date_range(in_progress_operations, date_range) 
    	]
    end

    private
      def self.query_customers_charts_operations(operations, date_range, modality, customer_id)
      	if modality == "ALL"
      		operations
      	else
      		if modality.nil? && !customer_id.nil?
      			query_by_customer(operations, customer_id)
      		elsif !modality.nil? && !customer_id.nil?
      			query_by_customer_and_modality(operations, customer_id, modality)
      		else
      			operations
      		end
      	end
      end
  end
end