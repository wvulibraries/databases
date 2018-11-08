class Vendor < ApplicationRecord
  # validations
  validates :name,
            presence: true,
            uniqueness: { case_sensitive: true },
            length: { within: 2..50 }

  validates :url, url: { allow_nil: true }

  # associations
  has_one :database,
          dependent: :nullify,
          required: false

end
