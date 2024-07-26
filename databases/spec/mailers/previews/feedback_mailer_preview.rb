# Preview all emails at http://localhost:3000/rails/mailers/feedback_mailer
class FeedbackMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/feedback_mailer/message
  def email_message
    content = Feedback.new(name: 'Joe', email: 'joe@mail.wvu.edu', feedback: 'Something Dark Side.', trial_database: Database.first.id.to_s)
    FeedbackMailer.email_message(content)
  end

end
