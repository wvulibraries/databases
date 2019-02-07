# Access plain text is an older feature that gave access types and variants. 
# 
# @author David J. Davis
# @deprecated This might be deprecated, keeping until approval from users.
class AccessPlainText < ApplicationRecord
  self.table_name = :access_plain_text

  # validations
  validates :name,
            presence: true,
            uniqueness: { case_sensitive: true },
            length: { within: 2..1000 }
end
