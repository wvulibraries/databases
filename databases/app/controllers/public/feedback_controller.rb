# Public::FeedbackController 
class Public::FeedbackController < ApplicationController
  include RecaptchaHandler
  
  # Rendering an index form for the feedback
  # @author David J. Davis
  def index
    @feedback = Feedback.new
    @databases = Database.all
    render :index
  end

  # Handles the posts from the feedback form.
  # @author David J. Davis
  def email_submission
    @feedback = Feedback.new(trusted_params)
    if verify_recaptcha_or_skip(model: @feedback) && @feedback.valid?
      FeedbackMailer.email_message(@feedback).deliver_now
      redirect_to root_path, success: 'Thank you for submitting feedback about a trial database.'
    else
      render :index
    end
  end

  private

  # trusted params that will be allowed for the feedback
  # @author David J. Davis
  def trusted_params
    params.require(:feedback).permit(:name, :email, :phone, :feedback, :trial_database)
  end
end
