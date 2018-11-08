require 'rails_helper'

RSpec.describe Vendor, type: :model do
  let(:vendor) { FactoryBot.create :vendor }

  context 'associations' do
    it { should have_one(:database) }
  end 

  context 'validates .name' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_length_of(:name).is_at_least(2).is_at_most(50) }
  end

  context 'vendor website or url' do
    it 'expects invalid url' do
      vendor.url = 'soemthing'
      expect(vendor).to_not be_valid
      expect(vendor.errors.messages[:url]).to eq ['is not a valid URL']
    end

    it 'expects valid url' do
      vendor.url = Faker::Internet.url
      expect(vendor).to be_valid
    end

    it 'allows nil items' do
      vendor.url = nil
      expect(vendor).to be_valid
    end
  end

  context 'testing the factory valid' do
    it { expect(vendor).to be_valid }
  end
end
