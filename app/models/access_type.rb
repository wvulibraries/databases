# Access type was a model from the old version that may have been fully replaced.  
#
# @author David J. Davis
# @deprecated This might be deprecated, keeping until approval from users.
class AccessType < ApplicationRecord
  # validations
  validates :name,
            presence: true,
            uniqueness: { case_sensitive: true },
            length: { within: 2..190 }
end
