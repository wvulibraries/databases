class ReportMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.feedback_mailer.message.subject
  def email_message(report)
    @report = report
    db_id = report.database
    @database = Database.find(db_id) if Database.exists?(db_id)
    subject = 'Database Error Report'
    
    # Fix the attachment handling
    unless report.screenshot.file.nil?
      # Use original_filename or identifier instead of title
      filename = report.screenshot.file.original_filename || "screenshot.#{report.screenshot.file.extension}"
      attachments[filename] = File.read(report.screenshot.file.path)
    end
    
    mail(to: ENV['reporting_email'], subject: subject)
  end
end
