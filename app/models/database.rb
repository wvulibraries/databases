# The main model for storing academic databases. 
# NOT DATABASE CONNECTIONS!
# @author David J. Davis
class Database < ApplicationRecord
  # TABLE NAME
  # -----------------------------------------------------
  self.table_name = :database_list

  # VALIDATIONS
  # -----------------------------------------------------
  validates :name,
            presence: true,
            length: { within: 2..190 }

  validates :url_uuid,
            uniqueness: { case_sensitive: true },
            length: { within: 2..50 }

  validates :libguides_id, 
            numericality: { :only_integer => true, :allow_nil => true }
  validates_uniqueness_of :libguides_id, :allow_blank => true, :allow_nil => true


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

  # ENUMS
  # -----------------------------------------------------
  enum status: { undefined: 0, production: 1, development: 2, hidden: 3 }
  validates :status, presence: true

  enum access: { 'Campus Only Access (No Proxy)' => 1, 
                 'Campus and Off Campus (Proxy)' => 2  }

  # ASSOCIATIONS
  # -----------------------------------------------------
  belongs_to :vendor, optional: true, required: false
  belongs_to :access_type, optional: true, required: false
  belongs_to :access_plain_text, optional: true, required: false

  # resources 
  has_many :database_resources
  has_many :resources, through: :database_resources

  # subjects
  has_many :database_subjects
  has_many :subjects, through: :database_subjects

  # curated subjects
  has_many :database_curated
  has_many :curated, through: :database_curated, source: :subject

  # landing page
  has_one :landing_page, required: false

  # CONCERNS
  # -----------------------------------------------------
  include Searchable

  # RAILS CALLBACKS
  # -----------------------------------------------------
  # default values
  before_validation :mint_uuid, on: [:create]
  after_initialize :set_defaults

  # SCOPES
  # -----------------------------------------------------
  scope :prod, -> { where(status: 'production') }
  scope :dev, -> { where(status: 'development') }
  scope :hide, -> { where(status: 'hidden') }
  scope :with_status, ->(status) { where(status: status) }
  scope :trials, -> { where(trial_database: true).where('trial_expiration_date > ?', DateTime.now) }
  scope :no_vendor, -> { where(vendor: nil) }
  scope :pop_list, -> { where(popular: true) }

  # scoping for alphabetical listing by titles
  scope :alpha_list, ->(letter) { where("name LIKE ?", "#{letter}%") }
  scope :number_list, -> { where("name REGEXP '^[0-9]'")}

  # scoping for subject listing 
  scope :list_subjects, ->(id) { includes(:subjects, :curated).order(:name).where(subjects: {id: id }, status: 'production') }
  scope :letters, -> { all.order('name ASC').group_by{ |db| db.name[0].upcase }.keys.reject { |i| i =~ /\A\d+\z/ }.uniq } 
  scope :grouped_alpha, -> { all.prod.order('name ASC').group_by{ |db| db.name[0].upcase } } 
  scope :total_count, -> { all.prod.count }

  # PUBLIC METHODS
  # -----------------------------------------------------

  # Uses Enum method to determine if something is published.
  # Only used in the search params for elasticsearch
  # @author David J. Davis
  # @return Boolean
  def published
    self.production?
  end

  # Creates keywords for indexing, filtering, search etc.
  # @author David J. Davis
  # @return string
  def keywords
    attr = [status, name, title_search, subject_list]
    attr.join(' ')
  end

  # Creates comma seperated list of subjects.
  # @author David J. Davis
  # @return string
  def subject_list
    list = []
    subjects.each { |subject| list << subject.name }
    list.to_sentence
  end

  # Creates groupings of subjects seprated by semi-colons. 
  # @author David J. Davis
  # @return string
  def subjects_column
    list = []
    subjects.each { |subject| list << subject.name }
    list.join(';')
  end

  # Creates groupings of resources seprated by semi-colons.
  # @author David J. Davis
  # @return string
  def resources_column
    list = []
    resources.each { |rss| list << rss.name }
    list.join(';')
  end

  # Creates comma seperated list of resources.
  # @author David J. Davis
  # @return string
  def resource_list
    list = []
    resources.each { |rss| list << rss.name }
    list.to_sentence
  end

  # Returns an array of names for search index.
  # @author David J. Davis
  # @return [Array]
  def subject_search_index
    subjects.pluck(:name)
  end

  # Returns an array of names for search index.
  # @author David J. Davis
  # @return [Array]
  def rss_search_index
    resources.pluck(:name)
  end

  # Returns an array of names for search index.
  # @author David J. Davis
  # @return [Array]
  def curated_search_index
    curated.pluck(:name)
  end

  # Calls the association for vendor unless nil, and returns the vendors name. 
  # @author David J. Davis
  # @return string or nil
  def vendor_name
    vendor&.name
  end

  # Checks to see if the campus only designation is set 
  # @author David J. Davis
  # @return boolean
  def campus_only?
    access == 'Campus Only Access (No Proxy)'
  end

  # Creates a csv object of all database records.
  # @author David J. Davis
  # @return csv object
  def self.to_csv
    CSV.generate(headers: true) do |csv|
      attributes = %w[
        id libguides_id name status years_of_coverage vendor_name url access 
        full_text_db help help_url description url_uuid new_database popular
        trial_database trial_expiration_date title_search subjects_column
        resources_column created_at updated_at
      ]

      csv << attributes.map(&:better_titleize)
      all.find_each do |database|
        csv << attributes.map { |attr| database.send(attr) }
      end
    end
  end 

  # Generates a CSV to populate libguides a-to-z listing.
  # @author David J. Davis
  # @return csv object
  def self.libguides_export
    headers = %w[
      vendor name url enable_proxy description more_info enable_new
      enable_trial types keywords target slug best_bets subjects
      desc_pos lib_note enable_popular enable_hidden internal_note
      owner resource_icons thumbnail content_id
    ]
    CSV.generate(headers: true) do |csv|
      csv << headers
      # get everything else
      all.find_each do |database|
        csv << database.csv_hash.values
      end
    end
  end

  # Creates a hash to use in the lib_guides CSV.
  # LibGuides requries the use of these fields
  # vendor name url enable_proxy description more_info enable_new enable_trial
  # types keywords target slug best_bets subjects desc_pos lib_note
  # enable_popular enable_hidden internal_note owner resource_icons
  # thumbnail content_id
  # @author David J. Davis
  # @return [Hash] Custom for LibGuides.
  def csv_hash
    {
      vendor: self.vendor_name,
      name: self.name,
      url: self.url,
      enable_proxy: self.access == 2 ? 1 : 0,
      description: self.description,
      more_info: '',
      enable_new: self.new_database.to_i,
      enable_trial: self.trial_database.to_i,
      types: self.resources.pluck(:name).join(';'),
      keywords: '',
      target: 0,
      slug: '',
      best_bets: self.curated.pluck(:name).join(';'),
      subjects: self.subjects.pluck(:name).join(';'),
      desc_pos: 1,
      lib_note: 0,
      enable_popular: self.popular.to_i,
      enable_hidden: 0,
      internal_note: '',
      owner: '',
      resource_icons: '',
      thumbnail: '',
      content_id: self.libguides_id
    }

  end

  # Elastic search settings using indexed json. 
  # @author David J. Davis
  # rake elasticsearch:import:model CLASS='Database' SCOPE="production" FORCE=y
  def as_indexed_json(_options)
    as_json(
      methods: [:vendor_name, :subject_search_index, :rss_search_index, :curated_search_index, :published],
      only: [:id, :name, :vendor_name, :description, :title_search]
    )
  end

  # Mapping the elasticsearch information to english language for better search.
  # @author David J. Davis
  mapping do
    indexes :name, type: :text, analyzer: 'english'
    indexes :vendor_name, type: :text, analyzer: 'english'
    indexes :description, type: :text,analyzer: 'english'
    indexes :subject_search_index, type: :text, analyzer: 'english'
    indexes :rss_search_index, type: :text, analyzer: 'english'
    indexes :curated_search_index, type: :text, analyzer: 'english'
    indexes :published, type: :boolean
  end

  # Seach query for searching with boosted items. 
  # Boosting Name and Vendorname in the search results.
  # @author David J. Davis
  def self.search(query, num = 1000)
    __elasticsearch__.search(
      "query": {
        "bool": {
          "must": [
            {
              "multi_match": {
                "query": query,
                "fields": [
                  'name^50',
                  'vendor_name^5',
                  'subject_search_index',
                  'curated_search_index',
                  'rss_search_index',
                  'description^2'
                ],
                "fuzziness": 1,
                "tie_breaker": 0.5
              }
            }, {
              "match": {
                "published": true
              }
            }
          ]
        }
      },
      "size": num
    )
  end

  # PRIVATE METHODS
  # -----------------------------------------------------

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
  def set_defaults
    self.help ||= ENV['help_text']
    self.help_url ||= ENV['help_url']
    self.created_at ||= DateTime.current
  end
  
end
