# Public::FeedbackController 
class Public::ReportController < ApplicationController
  include RecaptchaHandler
  
  # Rendering an index form for the report
  # @author David J. Davis
  def index
    @report = Report.new
    @databases = Database.all
    render :index
  end

  # Handles the posts from the report form.
  # @author David J. Davis
  def error_report
    @report = Report.new(trusted_params)
    if verify_recaptcha_or_skip(model: @report) && @report.valid?
      ReportMailer.email_message(@report).deliver_now
      redirect_to root_path, success: 'Thank you for submitting feedback about a trial database.'
    else
      render :index
    end
  end

  private

  # trusted params that will be allowed for the report
  # @author David J. Davis
  def trusted_params
    params.require(:report).permit(:name, :email, :error_report, :database, :screenshot)
  end
end
