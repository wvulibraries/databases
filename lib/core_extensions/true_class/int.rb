# extends the core ruby language
module CoreExtensions
  # extends the true class
  module TrueClass
    # integer
    module Integer
      # returns true as a 1 implicilty
      # @author David J. Davis
      # @return [Integer] 0
      def to_i
        1
      end
    end
  end
end

# include this in the core class
TrueClass.include CoreExtensions::TrueClass::Integer
