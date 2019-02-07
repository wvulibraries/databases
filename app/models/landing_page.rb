# Model for creating pages about each database.
# @author David J. Davis
class LandingPage < ApplicationRecord
  # associations 
  belongs_to :database, optional: true

  # valdiations 
  validates_presence_of :instructions, 
                        :contact_name, 
                        :contact_email, 
                        :contact_phone_number, 
                        :contact_title

  # Returns the database name negatting nil database
  # @author David J. Davis
  # @return string
  def database_name 
    self.database.nil? ? 'Not Assigned' : self.database.name 
  end 
end
