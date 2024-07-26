# Join Model for Databases and Resources. 
# @author David J. Davis
class DatabaseResource < ApplicationRecord
  # set table name
  self.table_name = :databases_resource_types

  # associations
  belongs_to :database
  belongs_to :resource
end
