class DatabaseSubject < ApplicationRecord
  # set table name
  self.table_name = :databases_subjects

  # associations
  belongs_to :database
  belongs_to :subject
end
