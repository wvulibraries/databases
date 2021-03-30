require 'rails_helper'

RSpec.feature "Admin::LinkTracking", type: :feature do

  context "#index" do
    scenario 'index page works and shows the proper h1' do
      visit 'admin/link_tracking'
      expect(page).to have_content(I18n.t('admin.link_tracking.index.heading'))
    end 

    scenario 'index page works and shows the proper h1 with passing start and end dates' do
      visit "admin/link_tracking?start_date=#{(Date.today - 1.month).to_s}&end_date=#{Date.today.to_s}&commit=Filter"
      expect(page).to have_content(I18n.t('admin.link_tracking.index.heading'))
    end   
    
    scenario 'index page with invalid end date' do
      visit "admin/link_tracking?start_date=#{(Date.today - 1.month).to_s}&end_date=sfdsfgsgsf&commit=Filter"
      expect(page).to have_content(I18n.t('admin.link_tracking.index.heading'))
      expect(page).to have_content(I18n.t('admin.link_tracking.index.filter_error'))
    end     
  end

end