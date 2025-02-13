# LOCAL CAPYBARA
# ============================================================
require 'capybara'

Capybara.run_server = true
Capybara.server_host = '0.0.0.0'
Capybara.server_port = 3001

Capybara.register_driver :remote_browser do |app|
  options = Selenium::WebDriver::Chrome::Options.new(args: %w[headless disable-gpu no-sandbox])
  Capybara::Selenium::Driver.new(
    app,
    browser: :remote,
    url: 'http://selenium:4444/wd/hub',
    options: options
  )
end

#uncomment this for local tests
Capybara.javascript_driver = :remote_browser

RSpec.configure do |config|
  config.before(:each) do
    Capybara.app_host = 'http://directory:3001'
  end

  config.after(:each) do
    Capybara.reset_sessions!
    Capybara.use_default_driver
    Capybara.app_host = nil
  end
end

