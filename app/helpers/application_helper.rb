module ApplicationHelper
  # checks if string is a number
  # @author David J. Davis
  # @return boolean
  def is_number? string
    true if Float(string) rescue false
  end
end
