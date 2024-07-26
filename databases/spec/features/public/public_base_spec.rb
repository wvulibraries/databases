require 'rails_helper'

RSpec.feature "Public::Base", type: :feature do
  let(:database) { FactoryBot.create(:database_basic) }
  let(:subject) { FactoryBot.create(:subject) }
  let(:landing_page) { FactoryBot.create(:landing_page) }

  context "#index" do
    before :each do
      database.status = "production"
      database.subjects << subject 
      database.save!
    end 

    it 'has a list of subjects and databases' do
      visit '/'
      expect(page).to have_content('Databases By Title')
      expect(page).to have_content(database.name[0])
      expect(page).to have_content('Databases By Subject')
      expect(page).to have_content(subject.name)
    end 

    context "popluar view" do
      it 'has a popular database set' do
        database.popular = true 
        database.save! 
        visit '/'
        expect(page).to have_content('Popular')
        expect(page).to have_content(database.name)
      end 

      it 'development popular does not show' do
        database.popular = true 
        database.status = "development"
        database.save! 
        visit '/'
        expect(page).to_not have_content('Popular')
        expect(page).to_not have_content(database.name)
      end 

      it 'does not have popular set' do
        database.popular = false 
        database.trial_database = false # needs this to keep the name out of there
        database.save! 
        visit '/'
        expect(page).to_not have_content('Popular')
        expect(page).to_not have_content(database.name)
      end
    end 

    context 'trial view' do
      it 'has trial view' do
        database.trial_database = true 
        database.trial_expiration_date = 1.year.from_now 
        database.popular = false 
        database.save! 
        visit '/'
        expect(page).to have_content('Trial Databases')
        expect(page).to have_content(database.name)
      end 

      it 'trial set to false' do
        database.trial_database = false
        database.trial_expiration_date = 1.year.from_now 
        database.popular = false 
        database.save! 
        visit '/'
        expect(page).to_not have_content('Trial Databases')
        expect(page).to_not have_content(database.name)
      end

      it 'trial expired' do
        database.trial_database = false
        database.trial_expiration_date = 1.year.ago 
        database.popular = false 
        database.save! 
        visit '/'
        expect(page).to_not have_content('Trial Databases')
        expect(page).to_not have_content(database.name)
      end
    end 
  end 

  context "AtoZ" do
    before :each do
      database.name = "Alpha"
      database.status = "production"
      database.save!
    end 

    it 'has a letter a link' do
      visit '/' 
      expect(page).to have_content('A')
    end  

    it 'expects the database to be listed under A' do
      visit '/AtoZ/a' 
      expect(page).to have_content("1 Results")
      expect(page).to have_content(database.name)
      expect(page).to have_content(database.description)
    end 
  end 

  context "AtoZ #num" do
    before :each do
      database.name = "12314Alpha"
      database.status = "production"
      database.save!
    end 

    it 'has a letter a link' do
      visit '/' 
      expect(page).to have_content('#')
    end  

    it 'expects the database to be listed under A' do
      visit '/AtoZ/NUM' 
      expect(page).to have_content("1 Results")
      expect(page).to have_content(database.name)
      expect(page).to have_content(database.description)
    end 
  end 

  context "AtoZ #all" do
    before :each do
      database.name = "Alpha"
      database.status = "production"
      database.save!
    end 

    it 'has a letter a link' do
      visit '/' 
      expect(page).to have_content('A')
    end  

    it 'lists all the database under /AtoZ' do
      visit '/AtoZ' 
      expect(page).to have_content("1 Results")
      expect(page).to have_content(database.name)
      expect(page).to have_content(database.description)
    end 

    it 'expects the database to be listed under A' do
      database.status = "development"
      database.save! 
      visit '/AtoZ' 
      expect(page).to have_content("0 Results")
      expect(page).to_not have_content(database.name)
      expect(page).to_not have_content(database.description)
    end 
  end 

  context "/subjects" do
    before :each do
      database.name = "Alpha"
      database.status = "production"
      database.subjects << subject 
      database.landing_page = landing_page
      database.save!
    end
    
    it 'lists all the subjects that have databases' do
      visit '/subjects'
      expect(page).to have_content(subject.name[0])
      expect(page).to have_content(subject.name)
    end 
  end 

  context "databases listed by subject" do
    before :each do
      database.name = "Alpha"
      database.status = "production"
      database.subjects << subject 
      database.landing_page = landing_page
      database.save!
    end
    
    it 'lists all the subjects that have databases' do
      visit "/subject/#{subject.id}"
      expect(page).to have_content("1 Results")
      expect(page).to have_content(database.name)
      expect(page).to have_content(database.description)
    end 
  end 
end