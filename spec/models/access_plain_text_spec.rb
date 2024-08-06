require 'rails_helper'

RSpec.describe AccessPlainText, type: :model do
  let(:apt) { FactoryBot.create :access_plain_text }

  context 'validates .name' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_length_of(:name).is_at_least(2).is_at_most(1000) }
  end

  context 'testing the factory valid' do
    it { expect(apt).to be_valid }
  end
end
