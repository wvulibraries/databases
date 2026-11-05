require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "action_mailbox/engine"
require "action_text/engine"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Databases
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Don't generate system test files.
    config.generators.system_tests = nil
    config.autoload_paths << Rails.root.join("app/services")

    # Add this line to silence the deprecation warning in CI
    config.active_support.deprecation = :silence if ENV['CI']

    # Opt in to Rails 8.1 behavior: to_time preserves the full timezone
    config.active_support.to_time_preserves_timezone = :zone
    
    # Precompile additional assets
    config.assets.precompile += %w( application.js )

    config.hosts << "*.lib.wvu.edu"
  end
end
