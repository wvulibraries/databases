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
      expect(decorator).to  include 'popular-title'
    end 

    it 'db is trial expects the class popular-title to be added to the string' do
      database.popular = false
      database.trial_database = true; 
      database.save! 
      decorator = DatabaseDecorator.new(database).display_title
      expect(decorator).to be_a(String)
      expect(decorator).to  include 'popular-title'
    end 

    it 'db is neither expects the class popular-title is not added' do
      database.popular = false
      database.trial_database = false; 
      database.save! 
      decorator = DatabaseDecorator.new(database).display_title
      expect(decorator).to be_a(String)
      expect(decorator).not_to  include 'popular-title'
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

  context ".title_link?" do
    it 'has a landing page and links properly' do
      database.landing_page = landing_page
      database.save! 
      link = DatabaseDecorator.new(database).title_link 
      expect(link).to eq "<a href='/about/#{database.url_uuid}'> #{database.name} </a>"
    end

    it 'no landing page director connect link' do
      database.landing_page = nil
      database.save! 
      link = DatabaseDecorator.new(database).title_link 
      expect(link).to eq "<a href='/connect/#{database.url_uuid}'> #{database.name} </a>"
    end
  end 

  context ".link_to_landing_page" do
    it 'expects string and url' do
      link = DatabaseDecorator.new(database).link_to_landing_page
      expect(link).to be_a(String)
      expect(link).to eq "/about/#{database.url_uuid}"
    end
  end 

  context ".link_to_database" do
    it 'expects string and url' do
      link = DatabaseDecorator.new(database).link_to_database
      expect(link).to be_a(String)
      expect(link).to eq "/connect/#{database.url_uuid}"
    end
  end 
end 