require 'rails_helper'

RSpec.feature "Public::Search", type: :feature do
  let(:database) { FactoryBot.create(:database_basic) }

  context "#index" do
    before :each do
      # need enough to create pages
      30.times do |i|
        FactoryBot.create :database_basic, name: "#{i} name", status: 'production'
      end 
      5.times do |i| 
        FactoryBot.create :database_basic, name: "#{i} dev name", status: 'development'
      end 

      Database.import(force: true, refresh: true)
    end 

    it 'search results' do
      visit "/search?query=name"
      expect(page).to have_content('Results 1 - 25 of 30')
      expect(page).to have_content('1 name')
      expect(page).to have_content('24 name')
      click_on '2'
      expect(page).to have_content('Results 26 - 30 of 30')
    end 
  end 

  context "keyword" do    
    before :each do
      database.status = "production"

      # Keywords are set in the title_search field
      database.title_search << " testing" 
      database.save!

      # force elasticsearch refresh
      Database.import(force: true, refresh: true)
    end

    it 'tests keyword search results' do
      visit "/search?query=testing"
      expect(page).to have_content(database.name)
    end
  end

end 