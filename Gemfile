source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.8'

# Rails Specific 
# =====================================================================================

# Rails, MySQL, Puma
gem 'rails', '~> 5.2.8.1'
gem 'mysql2', '>= 0.4.4', '< 0.6.0'
gem 'puma', '~> 5.6'

# Rails Dependencies
gem 'sassc-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

# gem 'concurrent-ruby', '~> 1.1', '>= 1.1.4'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# loads rails apps faster 
gem 'bootsnap', '>= 1.1.0', require: false

# Application Specific 
# =====================================================================================
# cas client
gem 'rack-cas', '~> 0.16.0'

# session store
gem 'activerecord-session_store'

# configurations 
gem "figaro"

# security / validation
gem 'validate_url'
gem 'sanitize'

# frontend
gem 'normalize-scss'
gem "non-stupid-digest-assets" # generates assets for 404/500/etc. 
gem "bourbon"
gem "neat"
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
  gem 'shoulda-matchers'
  gem 'database_cleaner'
  gem 'simplecov', '~> 0.10', '< 0.18'
  gem 'simplecov-console'
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'selenium-webdriver', '~> 3.14'    
  gem 'executables'
  gem 'rspec_junit_formatter'  
  gem 'rails-controller-testing'
  gem 'rack_session_access'
end

# Development / Test Items (Primarily debugging)
# =====================================================================================
group :development, :test do
  gem 'faker'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry'
  gem 'pry-rails'
  gem 'factory_bot_rails'  
end

group :development do
  gem 'web-console', '>= 3.3.0'  
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # performance helper
  gem 'bullet' # helps to eliminate N+1 Queries
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

