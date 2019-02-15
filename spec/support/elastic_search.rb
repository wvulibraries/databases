RSpec.configure do |config|
  config.before(:each) do
    Database.__elasticsearch__.create_index!
  end

  config.after(:each) do
    Database.__elasticsearch__.delete_index! if Database.__elasticsearch__.index_exists?
  end
end