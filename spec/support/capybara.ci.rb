require "selenium/webdriver"

chrome_bin = ENV.fetch('GOOGLE_CHROME_SHIM', nil)

chrome_opts = chrome_bin ? { "chromeOptions" => { "binary" => chrome_bin } } : { chromeOptions: { args: ['headless', 'disable-gpu', '--enable-features=NetworkService,NetworkServiceInProcess'] } }

Capybara.register_driver :chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new(args: %w[headless disable-gpu no-sandbox])
  Capybara::Selenium::Driver.new(
     app,
     browser: :chrome,
     options: options
  )
end

Capybara.javascript_driver = :chrome

