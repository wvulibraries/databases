require 'logger'
require 'logging'

# Ensure Logger constant is available
Object.const_set(:Logger, ::Logger) unless defined?(::Logger)