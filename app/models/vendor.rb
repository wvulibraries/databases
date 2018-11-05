class Vendor < ApplicationRecord
  # validations
  validates :name,
            presence: true,
            uniqueness: { case_sensitive: true },
            length: { within: 2..50 }

  validates :url, url: { allow_nil: true }
end
