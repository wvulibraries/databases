# Users - which cas users have access to the software. 
# @author David J. Davis
class User < ApplicationRecord
  # validation
  validates :first_name, presence: true, length: { within: 2..70 }
  validates :last_name, presence: true, length: { within: 2..70 }
  validates :cas_username, presence: true, length: { within: 4..100 }
  validates :cas_email, presence: true
  validate  :valid_email

  # A cancatenated string of names for display purposes. 
  # @author David J. Davis
  # @return [String] first_name last_name 
  def name 
    [first_name, last_name].join(' ')
  end 

  # Does a validation check on the email
  # @author David J. Davis
  # @return [Boolean] 
  def valid_email
    email_regex = !!(cas_email =~ /^[\w+\-.]+@[a-z\d\-]+[\.[a-z\d\-]+]*\.edu/i)
    errors.add :cas_email, I18n.t('users.valid_email') unless email_regex
  end
end
