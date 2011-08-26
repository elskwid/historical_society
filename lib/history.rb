require "history/version"

module History
  extend ActiveSupport::Concern
  # Model must include a deleted_at datetime column, default NULL
  included do
    default_scope lambda {
      field = [self.table_name, "deleted_at"].map{|str|"`#{str}`"}.join(".")
      where(["#{field} IS NULL OR (#{field} IS NOT NULL AND #{field} > ?)", Time.zone.now])
    }
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
      update_attribute(:deleted_at, Time.zone.now)
    end

  end
end
