require 'rails_helper'
require 'ipaddr'

describe DatabaseDecorator do
  let(:database) { FactoryBot.create(:database_basic) }
  let(:landing_page) { FactoryBot.create(:landing_page) }

  context ".display_title" do
    it 'db is popular expects the class popular-title to be added to the string' do
      database.popular = true
      database.trial_database = false; 
      database.save! 
      decorator = DatabaseDecorator.new(database).display_title
      expect(decorator).to be_a(String)
      expect(decorator).to eq("<h3 class='popular-title'> #{database.name} </h3>")
    end 

    it 'db is trial expects the class popular-title to be added to the string' do
      database.popular = false
      database.trial_database = true; 
      database.save! 
      decorator = DatabaseDecorator.new(database).display_title
      expect(decorator).to be_a(String)
      expect(decorator).to eq("<h3 class='popular-title'> #{database.name} </h3>")
    end 

    it 'db is neither expects the class popular-title is not added' do
      database.popular = false
      database.trial_database = false; 
      database.save! 
      decorator = DatabaseDecorator.new(database).display_title
      expect(decorator).to be_a(String)
      expect(decorator).to eq("<h3> #{database.name} </h3>")
    end 
  end

  context ".landing_page?" do
    it 'exists' do
      database.landing_page = landing_page
      database.save! 
      decorator = DatabaseDecorator.new(database).landing_page?
      expect(decorator).to be true
    end 
    it 'does not exist' do
      database.landing_page = nil
      database.save! 
      decorator = DatabaseDecorator.new(database).landing_page?
      expect(decorator).to be false
    end 
  end 
end 