class AccessType < ApplicationRecord
  # validations
  validates :name,
            presence: true,
            uniqueness: { case_sensitive: true },
            length: { within: 2..190 }
end
