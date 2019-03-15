require 'rails_helper'

RSpec.describe Feedback, type: :model do
  let(:feedback) { Feedback.new }

  context 'attribute accessors that the model responds too' do
    it 'name' do
      expect(feedback).to respond_to(:name)
    end

    it 'email' do
      expect(feedback).to respond_to(:email)
    end

    it 'phone' do
      expect(feedback).to respond_to(:phone)
    end

    it 'feedback' do
      expect(feedback).to respond_to(:feedback)
    end

    it 'trial_database' do
      expect(feedback).to respond_to(:trial_database)
    end
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:feedback) }
    it { should validate_presence_of(:trial_database) }
  end 
end
