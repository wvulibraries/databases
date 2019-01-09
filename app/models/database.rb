# The main model for storing academic databases. NOT DATABASE CONNECTIONS!
# @author David J. Davis
class Database < ApplicationRecord
  # set table name
  self.table_name = :database_list

  # validations
  validates :name,
            presence: true,
            length: { within: 2..190 }

  validates :url_uuid,
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
  # validates :off_campus_url, url: { allow_nil: true }

  # Boolean Validations
  # https://github.com/thoughtbot/shoulda-matchers/issues/512#issuecomment-50213690
  validates :popular, inclusion: { in: [true, false] }
  validates :new_database, inclusion: { in: [true, false] }
  validates :trial_database, inclusion: { in: [true, false] }
  validates :alumni, inclusion: { in: [true, false] }

  # enums
  enum status: { undefined: 0, production: 1, development: 2, hidden: 3 }
  validates :status, presence: true

  enum access: { 'Campus Only Access (No Proxy)' => 1, 
                 'Campus and Off Campus (Proxy)' => 2  }

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

  # curated subjects
  has_many :database_curated, dependent: :nullify
  has_many :curated, through: :database_curated, source: :subject

  # scopes
  scope :production, -> { where(status: 'production') }
  scope :development, -> { where(status: 'development') }
  scope :hidden, -> { where(status: 'hidden') }
  scope :with_status, ->(status) { where(status: status) }
  scope :trials, -> { where(trial_database: true) }
  scope :no_vendor, -> { where(vendor: nil) }

  # callbacks
  before_validation :mint_uuid, on: [:create]
  
  # default values 
  after_initialize :set_defaults

  # Creates keywords for indexing, filtering, search etc.
  # @author David J. Davis
  # @return string
  def keywords
    attr = [status, name, title_search, subject_list]
    attr.join(' ')
  end

  # Creates comma seperated list of subjects.
  # @author David J. Davis
  # @abstract 
  # @return string
  def subject_list
    list = []
    subjects.each { |subject| list << subject.name }
    list.to_sentence
  end

  # Creates comma seperated list of resources.
  # @author David J. Davis
  # @return string
  def resource_list
    list = []
    resources.each { |rss| list << rss.name }
    list.to_sentence
  end

  # Calls the association for vendor unless nil, and returns the vendors name. 
  # @author David J. Davis
  # @return string or nil
  def vendor_name
    vendor.name unless vendor.nil?
  end

  # Adjusts the presentation of the trail_expiration_date  
  # @author David J. Davis
  # @return string or nil
  # def trial_expiration_date
  #   self[:trial_expiration_date].strftime("%m/%d/%Y") unless self[:trial_expiration_date].nil?
  # end 

  # Creates a csv object of all database records.
  # @author David J. Davis
  # @return csv object
  def self.to_csv
    CSV.generate(headers: true) do |csv|
      attributes = %w{id name status years_of_coverage vendor_name url access full_text_db new_database trial_database access_plain_text help help_url description url_uuid popular trial_database trial_expiration_date title_search resource_list subject_list created_at updated_at}

      csv << attributes
      all.each do |database|
        csv << attributes.map{ |attr| database.send(attr) }
      end
    end
  end 

  private 

  # Minting a UUID creates a uuid for the record to use as a stable URL.
  # @author David J. Davis
  # @return truthy 
  def mint_uuid
    self.url_uuid ||= Time.now.to_i
  end

  # Some attributes are mostly going to be the same or provided as default values.
  # These attributes will be set automatically unless the items is set by the user.
  # @author David J. Davis
  # @abstract
  # @return truthy 
  # @TODO: This needs to be added to the configuration option.
  def set_defaults
    self.help ||= ENV['help_text']
    self.help_url ||= ENV['help_url']
  end
  
end
