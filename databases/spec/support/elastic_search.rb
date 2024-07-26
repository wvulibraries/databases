RSpec.configure do |config|
  config.before(:each) do
    begin
      Database.__elasticsearch__.create_index!
      Database.__elasticsearch__.refresh_index!
    rescue Elasticsearch::Transport::Transport::Errors::NotFound => e
    rescue => e
      STDERR.puts "There was an error creating the elasticsearch index for Database: #{e.inspect}"
    end
  end

  config.after(:each) do
    Database.__elasticsearch__.delete_index! if Database.__elasticsearch__.index_exists?
  end
end