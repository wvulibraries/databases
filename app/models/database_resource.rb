class DatabaseResource < ApplicationRecord
  # set table name
  self.table_name = :databases_resource_types

  # associations
  belongs_to :database
  belongs_to :resource
end
