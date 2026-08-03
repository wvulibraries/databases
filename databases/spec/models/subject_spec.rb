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

  context 'dependent destroy' do
      let(:subject) { FactoryBot.create :subject }
      let!(:database1) { FactoryBot.create :database_basic }
      let!(:database2) { FactoryBot.create :database_basic }

      before do
        subject.databases << database1
        subject.databases << database2
      end

      it 'removes associations when subject is destroyed' do
        expect(DatabaseSubject.where(subject_id: subject.id).count).to eq(2)
        subject.destroy
        expect(DatabaseSubject.where(subject_id: subject.id).count).to eq(0)
      end

      it 'does not delete the associated databases' do
        subject.destroy
        expect(Database.find_by(id: database1.id)).to be_present
        expect(Database.find_by(id: database2.id)).to be_present
      end
    end

  context 'subject website or url' do
    it 'expects invalid url' do
      subject.url = 'something'
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
