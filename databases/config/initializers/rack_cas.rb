require 'rack/cas'
require 'rack-cas/session_store/active_record'

Rails.application.config.middleware.use Rack::CAS,
  server_url: Rails.application.config_for(:application)["cas_url"],
  session_store: RackCAS::ActiveRecordStore,
  exclude_path: ->(path) { 
    path.start_with?('/assets') || 
    path.start_with?('/cable') || 
    path.start_with?('/favicon.ico') ||
    path.start_with?('/packs')
  }
