# Main Application helper which provides methods to views.
# @author David J. Davis
module ApplicationHelper
  # checks if string is a number
  # @author David J. Davis
  # @return [Boolean]
  def is_number? string
    true if Float(string) rescue false
  end

  # takes string and sets title for page
  # @author David J. Davis
  # @author Tracy A. McCormick
  def title(title)
    content_for(:title) { "Databases | #{title}" }
  end
end
