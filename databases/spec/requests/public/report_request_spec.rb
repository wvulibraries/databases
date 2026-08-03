require 'rails_helper'

RSpec.describe 'Public::ReportController', type: :request do
  let(:database) { create(:database_basic) }
  let(:report_params) do
    {
      report: {
        name: 'Test User',
        email: 'test@example.com',
        error_report: 'There is an issue',
        database: database.id.to_s
      }
    }
  end

  describe 'GET /report' do
    it 'renders the index page' do
      get '/report'
      expect(response).to be_successful
      expect(response).to render_template(:index)
    end

    it 'assigns a new Report instance' do
      get '/report'
      report = assigns(:report)
      expect(report).to be_an_instance_of(Report)
      expect(report).not_to be_persisted
    end

    it 'assigns all databases' do
      database
      get '/report'
      expect(assigns(:databases)).to include(database)
    end
  end

  describe 'POST /report' do
    before do
      # In development, recaptcha verification is skipped
      allow(Rails.env).to receive(:development?).and_return(true)
    end

    context 'with valid parameters' do
      it 'sends a report email' do
        expect {
          post '/report', params: report_params
        }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end

      it 'redirects to root with success message' do
        post '/report', params: report_params
        expect(response).to redirect_to(root_path)
        expect(flash[:success]).to be_present
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        {
          report: {
            name: '',
            email: 'invalid-email',
            error_report: ''
          }
        }
      end

      it 're-renders the index template on validation failure' do
        post '/report', params: invalid_params
        expect(response).to render_template(:index)
      end

      it 'does not send email on invalid parameters' do
        expect {
          post '/report', params: invalid_params
        }.not_to change { ActionMailer::Base.deliveries.count }
      end

      it 'assigns the report with errors' do
        post '/report', params: invalid_params
        expect(assigns(:report).errors).to be_present
      end
    end

    context 'with recaptcha verification' do
      before do
        allow(Rails.env).to receive(:development?).and_return(false)
      end

      it 'requires successful recaptcha verification in production' do
        allow_any_instance_of(Public::ReportController).to receive(:verify_recaptcha).and_return(false)
        post '/report', params: report_params
        expect(response).to render_template(:index)
      end

      it 'succeeds with valid recaptcha' do
        allow_any_instance_of(Public::ReportController).to receive(:verify_recaptcha).and_return(true)
        expect {
          post '/report', params: report_params
        }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end
    end
  end
end
