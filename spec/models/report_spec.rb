require 'rails_helper'

RSpec.describe Report, type: :model do
  let(:report) { Report.new }

  context 'attribute accessors that the model responds too' do
    it 'name' do
      expect(report).to respond_to(:name)
    end

    it 'email' do
      expect(report).to respond_to(:email)
    end

    it 'phone' do
      expect(report).to respond_to(:phone)
    end

    it 'error_report' do
      expect(report).to respond_to(:error_report)
    end

    it 'database' do
      expect(report).to respond_to(:database)
    end
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:error_report) }
    it { should validate_presence_of(:database) }
  end
end
