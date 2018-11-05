require 'rails_helper'

RSpec.describe AccessType, type: :model do
  let(:access_type) { FactoryBot.create :access_type }

  context 'validates .name' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_length_of(:name).is_at_least(2).is_at_most(190) }
  end

  context 'testing the factory valid' do
    it { expect(access_type).to be_valid }
  end
end
