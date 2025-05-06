require 'elasticsearch/model'

RSpec.configure do |config|
  config.before(:each) do
    begin
      # Make sure we're requiring the right libraries first
      require 'elasticsearch/model'
      
      # Create and refresh the index
      Database.__elasticsearch__.create_index! force: true
      Database.__elasticsearch__.refresh_index!
      
    # Handle different error types depending on gem version
    rescue Elasticsearch::Transport::Transport::Errors::NotFound => e
      # This is fine - the index might not exist yet
    rescue Elasticsearch::Client::NotFound => e
      # For newer elasticsearch client versions
    rescue => e
      STDERR.puts "There was an error creating the elasticsearch index for Database: #{e.inspect}"
      STDERR.puts e.backtrace.join("\n")
    end
  end

  config.after(:each) do
    begin
      # Only attempt to delete if the index exists
      if Database.__elasticsearch__.index_exists?
        Database.__elasticsearch__.delete_index!
      end
    rescue => e
      # Just log errors during cleanup, don't fail tests
      STDERR.puts "Error cleaning up elasticsearch index: #{e.message}"
    end
  end
end
