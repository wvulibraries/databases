# Preview all emails at http://localhost:3000/rails/mailers/report_mailer
class ReportMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/report_mailer/email_message
  def email_message
    content = Report.new(name: 'Joe', email: 'joe@mail.wvu.edu', error_report: 'Something Dark Side.', database: Database.first.id.to_s)
    ReportMailer.email_message(content)
  end

end
