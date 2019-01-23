require 'rails_helper'

RSpec.describe LandingPage, type: :model do
  context 'validate required data' do
    it { should validate_presence_of(:instructions) }
    it { should validate_presence_of(:contact_name) }
    it { should validate_presence_of(:contact_email) }
    it { should validate_presence_of(:contact_phone_number) }
    it { should validate_presence_of(:contact_title) }
  end
  
  context 'belongs to' do
    it { should belong_to(:database) }
  end
end
