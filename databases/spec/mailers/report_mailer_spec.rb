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

    it 'does not raise an error when database exists' do
      expect { mail }.not_to raise_error
    end

    context 'with all report fields populated' do
      it 'includes all report details in email body' do
        mail = ReportMailer.email_message(report)
        expect(mail.body.encoded).to have_content(report.name)
        expect(mail.body.encoded).to have_content(report.email)
        expect(mail.body.encoded).to have_content(report.error_report)
      end
    end
  end

end
