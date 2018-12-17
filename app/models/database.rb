class Database < ApplicationRecord
  # set table name
  self.table_name = :database_list

  # validations
  validates :name,
            presence: true,
            length: { within: 2..190 }

  validates :url_id,
            presence: true,
            uniqueness: { case_sensitive: true },
            length: { within: 2..50 }

  validates :years_of_coverage,
            length: { maximum: 50 }

  validates :url,
            presence: true,
            url: true

  validates :description,
            presence: true

  # Validate URL's *optional presence
  validates :help_url, url: { allow_nil: true }
  validates :off_campus_url, url: { allow_nil: true }

  # Boolean Validations
  # https://github.com/thoughtbot/shoulda-matchers/issues/512#issuecomment-50213690
  validates :popular, inclusion: { in: [true, false] }
  validates :new_database, inclusion: { in: [true, false] }
  validates :trial_database, inclusion: { in: [true, false] }
  validates :alumni, inclusion: { in: [true, false] }

  # enums
  enum status: { undefined: 0, production: 1, development: 2, hidden: 3 }
  validates :status, presence: true

  # associations
  belongs_to :vendor, optional: true, required: false
  belongs_to :access_type, optional: true, required: false
  belongs_to :access_plain_text, optional: true, required: false

  # resources 
  has_many :database_resources, dependent: :nullify
  has_many :resources, through: :database_resources

  # subjects
  has_many :database_subjects, dependent: :nullify
  has_many :subjects, through: :database_subjects

  # scopes
  scope :production, -> { where(status: 'production') }
  scope :development, -> { where(status: 'development') }
  scope :hidden, -> { where(status: 'hidden') }
  scope :trials, -> { where(trial_database: true) }

  # keywords
  # -----------------------------------------------------
  # @author David J. Davis
  # @description creates keywords for indexing, filtering, search etc.
  # @return string
  def keywords
    attr = [status, name, title_search, subject_list]
    attr.join(' ')
  end

  # subject_list
  # -----------------------------------------------------
  # @author David J. Davis
  # @description creates comma seperated list of subjects.
  # @return string
  def subject_list
    list = []
    subjects.each { |subject| list << subject.name }
    list.to_sentence
  end

   # resource_list
  # -----------------------------------------------------
  # @author David J. Davis
  # @description creates comma seperated list of resources.
  # @return string
  def resource_list
    list = []
    resources.each { |rss| list << rss.name }
    list.to_sentence
  end


end
