require 'rails_helper'

RSpec.feature "Admin::LinkTracking", type: :feature do

  context "#index" do
    scenario 'index page works and shows the proper h1' do
      visit 'admin/link_tracking'
      expect(page).to have_content("Database Link Tracking")
    end 

    scenario 'index page works and shows the proper h1 with passing start and end dates' do
      visit "admin/link_tracking?start_date=#{(Date.today - 1.month).to_s}&end_date=#{Date.today.to_s}&commit=Filter"
      expect(page).to have_content("Database Link Tracking")
    end   
    
    scenario 'index page with invalid end date' do
      visit "admin/link_tracking?start_date=#{Date.today - 1.month}&end_date=sfdsfgsgsf&commit=Filter"
      expect(page).to have_content("Database Link Tracking")
    end     
  end

end