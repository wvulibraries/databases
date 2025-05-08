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
    # Time Zone
    config.time_zone = 'Eastern Time (US & Canada)'
    config.active_record.default_timezone = :local

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # CAS
    # config.rack_cas.server_url = 'https://ssodev.wvu.edu/cas/' unless Rails.env.production?
    # config.rack_cas.server_url = 'https://sso.wvu.edu/cas/' if Rails.env.production?

    # presenters
    # config.autoload_paths += %W(#{config.root}/presenters)
    
    # force ssl
    # config.force_ssl = true if Rails.env.production?
    
    # session store
    config.session_store :active_record_store, expire_after: nil, secure: true if Rails.env.production?
    config.session_store :active_record_store, key: 'cas', expire_after: 12.hours, secure: true if Rails.env.production?
    # config.eager_load_paths << Rails.root.join("extras")

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.hosts << ".lib.wvu.edu"
  end
end
