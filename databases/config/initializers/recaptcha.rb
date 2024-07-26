# config/initializers/recaptcha.rb
Recaptcha.configure do |config|
  config.site_key = ENV['CAPTCHA_SITE'] # '6Lc6BAAAAAAAAChqRbQZcn_yyyyyyyyyyyyyyyyy'
  config.secret_key = ENV['CAPTCHA_SECRET'] # '6Lc6BAAAAAAAAKN3DRm6VA_xxxxxxxxxxxxxxxxx'
end
