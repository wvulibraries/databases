require 'rails_helper'

RSpec.describe DatabaseCurated, type: :model do
  # let(:subject) { FactoryBot.create :subject }
  # let(:database) { FactoryBot.create :database_basic }
  let(:database_curated) { FactoryBot.create(:database_curated) }

  context 'associations' do
    it { should belong_to(:database) }
    it { should belong_to(:subject) }
  end

  context 'enums' do 
    it { should define_enum_for(:sort).with({ 'High' => 3, 'Medium' => 2, 'Low' => 1, 'Default' => 0 }) }
  end 

  context '.database_name' do
    it "should return the database name" do
      expect(database_curated.database_name).to eq(database_curated.database.name)
    end 

    it "should return nil if database is nil" do
      database_curated.database = nil
      expect(database_curated.database_name).to be_nil
    end 

    it "should not be a valid object if the database is nil" do
      database_curated.database = nil
      expect(database_curated).to_not be_valid
    end 
  end 

  context '.subject_name' do
    it "should return the database name" do
      expect(database_curated.subject_name).to eq(database_curated.subject.name)
    end 

    it "should return nil if database is nil" do
      database_curated.subject = nil
      expect(database_curated.subject_name).to be_nil
    end 

    it "should not be a valid object if the database is nil" do
      database_curated.subject = nil
      expect(database_curated).to_not be_valid
    end 
  end 
end
