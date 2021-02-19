class LinkTracking < ApplicationRecord
  belongs_to :database, polymorphic: true

  # validations
  validates :database, 
            presence: true  
            
  validates :ip_address,
            presence: true,
            length: { within: 7..15 }  
end
