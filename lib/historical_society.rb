require "historical_society/version"

module HistoricalSociety
  extend ActiveSupport::Concern
  # Model must include a deleted_at datetime column, default NULL
  included do
    default_scope lambda {
      table_name  = self.connection.quote_table_name(self.table_name)
      column_name = self.connection.quote_column_name("deleted_at")
      field       = "#{table_name}.#{column_name}"

      where([
        "#{field} IS NULL OR (#{field} IS NOT NULL AND #{field} > ?)",
        historical_time
      ])
    }
  end

  module ClassMethods
    def historical_time
      (Time.zone || Time).now
    end
  end

  module InstanceMethods

    def destroy
      set_deleted_at
    end

    def delete
      set_deleted_at
    end

    private

    def set_deleted_at
      update_attribute(:deleted_at, self.class.historical_time)
    end

  end
end
