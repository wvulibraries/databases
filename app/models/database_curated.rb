# Creates a curated list of database per each subject and gives them a hierarchy.  
# @author David J. Davis
class DatabaseCurated < ApplicationRecord
  # set table name
  self.table_name = :databases_curated

  # associations
  belongs_to :database
  belongs_to :subject

  # sorting
  enum sort: { 'High' => 3, 
               'Medium' => 2,  
               'Low' => 1,
               'Default' => 0
             }

  # Returns the Subjects Name unless the item is nil
  # @author David J. Davis
  # @return string
  def subject_name 
    subject.name unless subject.nil?
  end
  
  # Returns the Databses name unles the itme is nil
  # @author David J. Davis
  # @return string
  def database_name 
    database.name unless database.nil?
  end 
end
