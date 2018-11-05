class AccessPlainText < ApplicationRecord
  self.table_name = :access_plain_text

  # validations
  validates :name,
            presence: true,
            uniqueness: { case_sensitive: true },
            length: { within: 2..1000 }
end
