# Subjects are used in searching and finding databases and curations.
# @author David J. Davis
class Subject < ApplicationRecord
  # validatations
  validates :name,
            presence: true,
            uniqueness: { case_sensitive: true },
            length: { within: 2..50 }

  validates :url, url: { allow_blank: true }

  # associations
  has_many :database_subjects, dependent: :nullify
  has_many :databases, through: :database_subjects
end
