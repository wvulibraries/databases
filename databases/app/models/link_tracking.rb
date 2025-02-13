class LinkTracking < ApplicationRecord
  belongs_to :database, polymorphic: true

  # validations
  validates :database, 
            presence: true  

  validates :ip_address,
            presence: true,
            length: { within: 7..15 } 
            
  # scoping for count 
  scope :total_count, -> { all.count }
  
  scope :prev_month_count, -> { where('created_at < ?', DateTime.now).count } 
  scope :current_month_count, -> { where('created_at < ?', DateTime.now).count } 
end
