require 'rails_helper'

RSpec.describe Subject, type: :model do
  let(:subject) { FactoryBot.create :subject }

  context 'validates name' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_length_of(:name).is_at_least(2).is_at_most(50) }
  end

  context 'associations' do
    it { should have_many(:databases) }
  end

  context 'subject website or url' do
    it 'expects invalid url' do
      subject.url = 'soemthing'
      expect(subject).to_not be_valid
      expect(subject.errors.messages[:url]).to eq ['is not a valid URL']
    end

    it 'expects valid url' do
      subject.url = Faker::Internet.url
      expect(subject).to be_valid
    end

    it 'allows nil items' do
      subject.url = nil
      expect(subject).to be_valid
    end
  end

  context 'testing the factory valid' do
    it { expect(subject).to be_valid }
  end
end
