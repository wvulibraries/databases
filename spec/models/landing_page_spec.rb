require 'rails_helper'

RSpec.describe LandingPage, type: :model do
  let(:database) { FactoryBot.create(:database_basic) }
  let(:landing_page) { FactoryBot.create(:landing_page) }

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

  context '.database_name' do
    it "sucessful name" do
      database.landing_page = landing_page
      database.save! 
      expect(landing_page.database_name).to eq(database.name)
    end 
    it "none assigned" do
      database.landing_page = nil
      database.save! 
      expect(landing_page.database_name).to eq('Not Assigned')
    end 
  end 
end
