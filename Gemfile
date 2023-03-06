source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

# Rails Specific 
# =====================================================================================
gem 'rails', '~> 5.2.8.1'
gem 'mysql2', '>= 0.4.4', '< 0.6.0'
gem 'puma', '~> 4.3'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'concurrent-ruby', '~> 1.1', '>= 1.1.4'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'
gem 'bootsnap', '>= 1.1.0', require: false

# Application Specific 
# =====================================================================================
# cas client
gem 'rack-cas', '~> 0.16.0'

# configurations 
gem "figaro"

# security / validation
gem 'validate_url'
gem 'sanitize'

# frontend
gem "bourbon"
gem "neat"
gem 'normalize-scss'
gem "non-stupid-digest-assets" # generates assets for 404/500/etc. 
gem "recaptcha" # google recaptcha api
gem 'carrierwave'

# searching / indexing
gem 'kaminari' # must be before elasticsearch
gem 'elasticsearch-model'
gem 'elasticsearch-rails'

# jobs
gem 'whenever', require: false

# Test Suite
# =====================================================================================
group :test do
  gem 'rspec-rails'
  gem 'rails-controller-testing'
  gem 'rack_session_access'
  gem 'shoulda-matchers'
  gem "factory_bot_rails"
  gem 'database_cleaner'
  gem 'simplecov', '~> 0.10', '< 0.18'
  gem 'simplecov-console'
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'selenium-webdriver', '~> 3.14'  
  gem 'executables'
  gem 'rspec_junit_formatter'  
end

# Development / Test Items (Primarily debugging)
# =====================================================================================
group :development, :test do
  gem 'faker'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry'
  gem 'pry-rails'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
  # performance helper
  gem 'bullet' # helps to eliminate N+1 Queries
end

