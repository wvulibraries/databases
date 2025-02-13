require 'rails_helper'

RSpec.feature "Public::Base", type: :feature do
  let(:database) { FactoryBot.create(:database_basic) }
  let(:subject) { FactoryBot.create(:subject) }
  let(:landing_page) { FactoryBot.create(:landing_page) }

  context "#index" do
    before :each do
      database.status = "production"
      database.subjects << subject 
      database.landing_page = landing_page 
      database.save!
    end 

    it 'has a list of subjects and databases' do
      visit "/about/#{database.url_uuid}"
      expect(page).to have_content(database.name)
      expect(page).to have_content(database.description)
      expect(page).to have_content(landing_page.instructions)
      expect(page).to have_content(landing_page.contact_name)
      expect(page).to have_content(landing_page.contact_title)
      expect(page).to have_content(landing_page.contact_email)
      expect(page).to have_content(landing_page.contact_phone_number)
    end 
  end

end 