require_relative 'boot'

require 'rails'
require 'csv'
require 'ipaddr'

# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
require 'sprockets/railtie'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Databases
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # auto loading
    config.eager_load_paths << Rails.root.join('lib')
    config.autoload_paths << Rails.root.join('lib')

    # Timezone
    config.time_zone = ENV['time_zone']
    config.active_record.default_timezone = :local

    # CAS
    config.rack_cas.server_url = ENV['cas_url']

    config.web_console.permissions = '157.182.112.128/27'

    # security
    config.force_ssl = ENV['ssl'] if Rails.env.production?

    # session store
    config.session_store :cookie_store, expire_after: nil, secure: true if Rails.env.production?
    config.session_store :cookie_store, key: 'cas', expire_after: 12.hours, secure: true if Rails.env.production?

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Don't generate system test files.
    config.generators.system_tests = nil
    config.generators do |g|
      g.assets            false
      g.helper            false
      g.jbuilder          false
      g.stylesheets     false
      g.javascripts     false
      g.test_framework  :rspec,
                        fixtures: true,
                        view_specs: false,
                        helper_specs: false,
                        routing_specs: true,
                        controller_specs: false,
                        feature_specs: true,
                        request_specs: true
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
    end
  end
end
