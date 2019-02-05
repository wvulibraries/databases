class LandingPage < ApplicationRecord
  # associations 
  belongs_to :database, optional: true

  # valdiations 
  validates_presence_of :instructions, 
                        :contact_name, 
                        :contact_email, 
                        :contact_phone_number, 
                        :contact_title
end
