module Charts  
  class Representative
    include OperationQueriable
    include ChartTimeOrganizable

    def self.fetch_representatives_charts(date_range, modality, representative)
      modality = modality == 'ALL' ? nil : modality
    
      all_operations = query_representatives_charts(set_general_operations, date_range ,modality, representative)
      comleted_operations = query_representatives_charts(set_general_operations.where('operations.status =?', 'COMPLETED'), date_range, modality, representative)
      in_progress_operations = query_representatives_charts(set_general_operations.where.not('operations.status =?', 'COMPLETED'), date_range, modality, representative)

      charts_info = [
        set_charts_date_range(all_operations, date_range), 
        set_charts_date_range(comleted_operations, date_range), 
        set_charts_date_range(in_progress_operations, date_range)
      ]
    end

    private
      def self.query_representatives_charts(operations, date_range, modality, representative)
        if modality == "ALL"
          operations
        else
          if modality.nil? && !representative.nil?
            query_by_representative(operations, representative)
          elsif !modality.nil? && !representative.nil?
            query_by_representative_and_modality(operations, representative, modality)
          else
            operations
          end
        end
      end
  end
end