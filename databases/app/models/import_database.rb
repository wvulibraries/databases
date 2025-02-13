# form model for error reporting.
# @author David J. Davis
class ImportDatabase
  # extending ruby base class with rails stuff
  include ActiveModel::Model
  extend CarrierWave::Mount

  # setters / getters
  attr_accessor :csv

  # validations
  validates :csv, presence: true
  validates_with CarrierWave::Validations::ActiveModel::IntegrityValidator, attributes: %i(csv)

  # carrierwave uploader
  mount_uploader :csv, CsvUploader
end
