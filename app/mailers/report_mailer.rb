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
    attachments[report.screenshot.title] = File.read(report.screenshot.attachment.file.path) unless report.screenshot.file.nil?
    mail(to: ENV['reporting_email'], subject: subject)
  end
end
