require 'rack/cas'
require 'rack-cas/session_store/active_record'

# Skip CAS in test/CI environments
if Rails.env.test? || ENV['CI']
  # Don't use Rack::CAS in test environments
  Rails.logger.info "Skipping Rack::CAS in test/CI environment"
else
  begin
    cas_url = Rails.application.config_for(:application)["cas_url"]
    
    Rails.application.config.middleware.use Rack::CAS,
      server_url: cas_url,
      session_store: RackCAS::ActiveRecordStore,
      exclude_path: ->(path) { 
        path.start_with?('/assets') || 
        path.start_with?('/cable') || 
        path.start_with?('/favicon.ico') ||
        path.start_with?('/packs')
      }
  rescue => e
    Rails.logger.error "Failed to configure Rack::CAS: #{e.message}"
  end
end
