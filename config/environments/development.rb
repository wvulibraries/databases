Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options)
  config.active_storage.service = :local

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

   # BULLET warn of N+1 and excessive queries
   config.after_initialize do
    Bullet.enable = true
    Bullet.alert = true 
    Bullet.console = false
    Bullet.rails_logger = false
  end

  # Email Tests
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_deliveries    = false
  config.action_mailer.delivery_method       = :smtp
  config.action_mailer.default_url_options   = { :host => 'databases.lib.wvu.edu' }
  config.action_mailer.preview_path = Rails.root.join('spec', 'mailers', 'previews')

  config.action_mailer.smtp_settings = {
    address: "smtp.wvu.edu",
    port: 25,
    enable_starttls_auto: true
  }
  
  # Remove IP restrictions for Admin login to authenticate databases_app using ssodev (default is to only allow local IPs/loopback, etc).
  config.web_console.whiny_requests = false

  # Allow ssodev.wvu.edu to redirect back to your application
  # Replace config.hosts (Rails 6+) with Rails 5.2 compatible configuration
  config.action_dispatch.tld_length = 2
  # Or alternatively, disable host checking entirely in development (less secure)
  # config.action_dispatch.hosts_response_app = proc { [200, {}, ['OK']] } 
end

