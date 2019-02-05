source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

# Rails Specific 
# =====================================================================================
gem 'rails', '~> 5.2.1'
gem 'mysql2', '>= 0.4.4', '< 0.6.0'
gem 'puma', '~> 3.11'
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
# configurations 
gem "figaro"

# security / validation
gem 'validate_url'
gem 'sanitize'

# frontend
gem "bourbon"
gem "neat"
gem 'normalize-scss'
gem 'font-awesome-sass'
gem "non-stupid-digest-assets" # generates assets without fingerprint for 404 and 500 errors. 

# breadcrumbs
gem "breadcrumbs_on_rails"

# schema to scaffold, only needed really to get us started
gem 'schema_to_scaffold'

# Test Suite
# =====================================================================================
group :test do
  gem 'rspec-rails'
  gem 'rails-controller-testing'
  gem 'shoulda-matchers'
  gem "factory_bot_rails"
  gem 'database_cleaner'
  gem 'simplecov'
  gem 'simplecov-console'
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'capybara-webkit', github: 'thoughtbot/capybara-webkit', branch: 'master'
  gem 'selenium-webdriver', '~> 3.14'  
  gem 'executables'
end

# Developoment / Test Items (Primarily debugging)
# =====================================================================================
group :development, :test do
  gem 'faker', :git => 'https://github.com/stympy/faker.git', :branch => 'master'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry'
  gem 'pry-rails'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'bullet'
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
