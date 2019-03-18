class FeedbackMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.feedback_mailer.message.subject
  def email_message(feedback)
    @feedback = feedback
    db_id = feedback.trial_database
    @database = Database.find(db_id) if Database.exists?(db_id)
    subject = 'Database Feedback'
    mail(to: ENV['reporting_email'], subject: subject)
  end
end
