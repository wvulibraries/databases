require 'rails_helper'

RSpec.describe ReportMailer, type: :mailer do
  describe 'email_message' do
    let(:database) { FactoryBot.create(:database_default_values) }
    let(:report) do
      Report.new( name: 'Joe',
                  email: 'joe@mail.wvu.edu',
                  error_report: 'Something Dark Side.',
                  database: database.id.to_s )
    end
    
    let(:mail) { ReportMailer.email_message(report) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Database Error Report')
      expect(mail.to).to eq([ENV['reporting_email']])
      expect(mail.from).to eq(['libsys@mail.wvu.edu'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to have_content('Joe')
      expect(mail.body.encoded).to have_content('joe@mail.wvu.edu')
      expect(mail.body.encoded).to have_content('Something Dark Side.')
      expect(mail.body.encoded).to have_content(database.name)
    end
  end

end
