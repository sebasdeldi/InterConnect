module OperationSortable
  extend ActiveSupport::Concern

  module ClassMethods

    def sort_operations(sort_param, operations)
      if sort_param == "newest"
        operations.order(created_at: :desc)
      elsif sort_param == "oldest"
        operations.order(created_at: :asc)
      elsif sort_param == "more_progress"
        operations.order('operations.current_step DESC')
      elsif sort_param == 'less_progress'
        operations.order('operations.current_step ASC')
      else
        operations.order(created_at: :desc)
      end 
    end
  end
end