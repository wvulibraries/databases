require 'rails_helper'

RSpec.describe Resource, type: :model do
  let(:resource_type) { FactoryBot.create :resource_type }

  context 'validate required data' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(100) }
    it { should validate_length_of(:name).is_at_least(2) }
  end
end
