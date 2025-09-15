require 'rack/cas'
require 'rack-cas/session_store/active_record'

if Rails.env.test? || ENV['CI']
  Rails.logger.info "Skipping Rack::CAS in test/CI environment"
  Rails.application.config.middleware.use Rack::Static,
    urls: ["/login", "/logout"],
    header_rules: [[:all, {'Cache-Control' => 'no-cache'}]]
else
  begin
    cas_url = Rails.application.config_for(:application)["cas_url"]

    # NOTE: rack-cas 0.16.1 supports `exclude_path` (Regexp or object responding to `===`)
    # We use a single Regex that matches /api, /oauth, assets, cable, packs, favicon.
    exclude_re = %r{\A/(api|oauth|assets|cable|packs|favicon\.ico)(/|$)}i
    Rails.logger.info "[Rack::CAS] exclude_path regex: #{exclude_re.inspect}"

    Rails.application.config.middleware.use Rack::CAS,
      server_url: cas_url,
      session_store: RackCAS::ActiveRecordStore,
      exclude_path: exclude_re

    Rails.logger.info "Configured Rack::CAS with server URL: #{cas_url}"
  rescue => e
    Rails.logger.error "Failed to configure Rack::CAS: #{e.message}"
  end
end
