# extends the core ruby language
module CoreExtensions
  # extends the false class
  module FalseClass
    # integer
    module Integer
      # returns false as a 0 implicilty
      # @author David J. Davis
      # @return [Integer] 0
      def to_i
        0
      end
    end
  end
end

# include this in the core class
FalseClass.include CoreExtensions::FalseClass::Integer
