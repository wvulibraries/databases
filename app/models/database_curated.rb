class DatabaseCurated < ApplicationRecord
  # set table name
  self.table_name = :databases_curated

  # associations
  belongs_to :database
  belongs_to :subject
end
