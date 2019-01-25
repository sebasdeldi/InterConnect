module ChartTimeOrganizable
  extend ActiveSupport::Concern

  module ClassMethods
    def set_charts_date_range(operations, date_range)
      if date_range == "day"
        operations
          .references(:operations)
          .group_by_day('operations.created_at')
          .count
      elsif date_range == "week"
        operations
          .references(:operations)
          .group_by_week('operations.created_at')
          .count
      elsif date_range == "month"
        operations
          .references(:operations)
          .group_by_month('operations.created_at')
          .count
      elsif date_range == "year"
        operations
          .references(:operations)
          .group_by_year('operations.created_at')
          .count
      end       
    end
  end
end