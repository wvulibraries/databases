require 'rails_helper'

RSpec.describe ImportDatabase, type: :model do
  let(:import) { ImportDatabase.new }

  context 'attribute accessors that the model responds too' do
    it 'csv' do
      expect(import).to respond_to(:csv)
    end
  end

  context 'validations' do
    it { should validate_presence_of(:csv) }
  end
end
