class Resource < ApplicationRecord
  self.table_name = 'resource_types'

  # validations
  validates :name,
            presence: true,
            length: { within: 2..100 }

  # associations
  has_many :database_resources, dependent: :nullify
  has_many :databases, through: :database_resources
end
