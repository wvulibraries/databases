require 'rails_helper'

RSpec.describe 'Public::FeedbackController', type: :request do
  let(:database) { create(:database_basic) }
  let(:feedback_params) do
    {
      feedback: {
        name: 'Test User',
        email: 'test@example.com',
        phone: '555-1234',
        feedback: 'Great resource',
        trial_database: database.id.to_s
      }
    }
  end

  describe 'GET /feedback' do
    it 'renders the index page' do
      get '/feedback'
      expect(response).to be_successful
      expect(response).to render_template(:index)
    end

    it 'assigns a new Feedback instance' do
      get '/feedback'
      feedback = assigns(:feedback)
      expect(feedback).to be_an_instance_of(Feedback)
      expect(feedback).not_to be_persisted
    end

    it 'assigns all databases' do
      database
      get '/feedback'
      expect(assigns(:databases)).to include(database)
    end
  end

  describe 'POST /feedback' do
    before do
      # In development, recaptcha verification is skipped
      allow(Rails.env).to receive(:development?).and_return(true)
    end

    context 'with valid parameters' do
      it 'sends a feedback email' do
        expect {
          post '/feedback', params: feedback_params
        }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end

      it 'redirects to root with success message' do
        post '/feedback', params: feedback_params
        expect(response).to redirect_to(root_path)
        expect(flash[:success]).to be_present
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        {
          feedback: {
            name: '',
            email: 'invalid-email',
            feedback: ''
          }
        }
      end

      it 'does not send email on invalid parameters' do
        expect {
          post '/feedback', params: invalid_params
        }.not_to change { ActionMailer::Base.deliveries.count }
      end

      it 're-renders the index template on validation failure' do
        post '/feedback', params: invalid_params
        expect(response).to render_template(:index)
      end

      it 'assigns the feedback with errors' do
        post '/feedback', params: invalid_params
        expect(assigns(:feedback).errors).to be_present
      end
    end

    context 'with recaptcha verification' do
      before do
        allow(Rails.env).to receive(:development?).and_return(false)
      end

      it 'requires successful recaptcha verification in production' do
        allow_any_instance_of(Public::FeedbackController).to receive(:verify_recaptcha).and_return(false)
        post '/feedback', params: feedback_params
        expect(response).to render_template(:index)
      end

      it 'succeeds with valid recaptcha' do
        allow_any_instance_of(Public::FeedbackController).to receive(:verify_recaptcha).and_return(true)
        expect {
          post '/feedback', params: feedback_params
        }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end
    end
  end
end
