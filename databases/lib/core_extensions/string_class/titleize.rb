# extends the core ruby language
module CoreExtensions
  # stringclass
  module String
    # returns a properly titlized string
    # @author David J. Davis
    # @return [String]
    def better_titleize
      split('_').map(&:capitalize).join(' ')
    end
  end
end

# include this in the core class
String.include CoreExtensions::String
