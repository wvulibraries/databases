# A simple model that does not have a table. 
# This is used to setup the email form and perform validations. 
# @author David J. Davis
class Feedback
  include ActiveModel::Model

  # setters / getters
  attr_accessor :trial_database, :feedback, :name, :email, :phone

  # validations
  validates :trial_database, :feedback, :name, :email, presence: true
end
