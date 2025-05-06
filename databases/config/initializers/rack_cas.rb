require 'rack/cas'
require 'rack-cas/session_store/active_record'

# Only use Rack::CAS middleware if not in test/ci environment
if !Rails.env.test? && !ENV['CI']
  cas_url = Rails.application.config_for(:application)["cas_url"] rescue nil
  
  if cas_url.present?
    Rails.application.config.middleware.use Rack::CAS,
      server_url: cas_url,
      session_store: RackCAS::ActiveRecordStore,
      exclude_path: ->(path) { 
        path.start_with?('/assets') || 
        path.start_with?('/cable') || 
        path.start_with?('/favicon.ico') ||
        path.start_with?('/packs')
      }
  else
    Rails.logger.warn "CAS URL not configured. Skipping Rack::CAS middleware."
  end
end
