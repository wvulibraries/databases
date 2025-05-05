module RecaptchaHandler
  extend ActiveSupport::Concern

  # Verify recaptcha or skip in development
  def verify_recaptcha_or_skip(model: nil)
    if Rails.env.development?
      true # Always pass in development
    else
      verify_recaptcha(model: model)
    end
  end
end