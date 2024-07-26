# form model for error reporting.
# @author David J. Davis
class Report
  # extending ruby base class with rails stuff
  include ActiveModel::Model
  extend CarrierWave::Mount

  # setters / getters
  attr_accessor :database, :error_report, :name, :email, :phone, :screenshot

  # validations
  validates :database, :error_report, :name, :email, presence: true
  validates_with CarrierWave::Validations::ActiveModel::IntegrityValidator, attributes: %i(screenshot)

  # carrierwave uploader
  mount_uploader :screenshot, ScreenShotUploader
end
