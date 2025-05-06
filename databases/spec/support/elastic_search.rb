# Make sure we're requiring the correct libraries
require 'elasticsearch'

RSpec.configure do |config|
  config.before(:suite) do
    begin
      # For newer elasticsearch gem
      client = Elasticsearch::Client.new(url: ENV['ELASTICSEARCH_URL'] || 'http://localhost:9200')
      
      # Delete and recreate the index
      begin
        client.indices.delete(index: 'databases_test')
      rescue => e
        # It's okay if the index doesn't exist yet
        puts "Note: #{e.message} (this is normal if the index didn't exist)"
      end
      
      # Create the index
      client.indices.create(
        index: 'databases_test',
        body: {
          mappings: {
            properties: {
              # Your mappings here
              title: { type: 'text' },
              description: { type: 'text' }
              # Add other fields as needed
            }
          }
        }
      )
    rescue => e
      puts "Error setting up Elasticsearch test index: #{e.message}"
      puts e.backtrace.join("\n")
    end
  end
end
