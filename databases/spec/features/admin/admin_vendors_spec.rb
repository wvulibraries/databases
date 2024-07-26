require 'rails_helper'

RSpec.feature "Admin::Vendors", type: :feature do

  let(:vendor) { FactoryBot.create(:vendor) }
  let(:attrs) { FactoryBot.attributes_for(:vendor) }
  let(:database) { FactoryBot.create(:database_basic) }

  context "#index" do
    scenario 'index page works and shows the data from the first record' do
      vendor # create a database 
      visit 'admin/vendors'
      expect(page).to have_content(vendor.name)
      expect(page).to have_content(vendor.url)
    end 
  end
  
  context "#create" do
    scenario 'successful create' do
      visit '/admin/vendors/new'
      fill_in 'Name', with: attrs[:name]
      fill_in 'Url', with: attrs[:url]
      click_button 'Create Vendor'
      expect(page).to have_content( I18n.t('admin.basic.messages.created', model: 'vendor'))
    end

    scenario 'failed without name' do
      visit '/admin/vendors/new'
      fill_in 'Url', with: attrs[:url]
      click_button 'Create Vendor'
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content('Name is too short (minimum is 2 characters)')
      expect(page).to have_content('2 errors')
    end 

    scenario 'failed without valid url' do
      visit '/admin/vendors/new'
      fill_in 'Name', with: attrs[:name]
      fill_in 'Url', with: 'not url'
      click_button 'Create Vendor'
      expect(page).to have_content("Url is not a valid URL")
      expect(page).to have_content('1 error')
    end 
  end

  context '#update' do
    before :each do
      vendor #instantiate
    end 

    scenario 'successful update' do
      visit "/admin/vendors/#{vendor.id}/edit"
      fill_in 'Name', with: 'Changing the Name'
      click_button 'Update Vendor'
      expect(page).to have_content(I18n.t('admin.basic.messages.updated', model: 'vendor'))
    end

    scenario 'failing update name' do
      visit "/admin/vendors/#{vendor.id}/edit"
      fill_in 'Name', with: ''
      click_button 'Update Vendor'
      expect(page).to have_content("2 errors")
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Name is too short (minimum is 2 characters)")
    end 

    scenario 'failing update valid url' do
      visit "/admin/vendors/#{vendor.id}/edit"
      fill_in 'Url', with: 'not url'
      click_button 'Update Vendor'
      expect(page).to have_content("Url is not a valid URL")
      expect(page).to have_content('1 error')
    end 
  end 

  context '#delete' do
    before :each do
      vendor # instantiate
    end 

    scenario 'deletes databases' do
      visit '/admin/vendors'
      click_link 'Delete'
      expect(page).to have_content('Vendors')
      expect(page).to have_content( I18n.t('admin.basic.messages.deleted', model: 'vendor'))
      expect(page).to_not have_content(vendor.name)
    end
  end 

  context '#show' do
    before :each do
      vendor 
      database.vendor = vendor
      database.save!
    end 

    scenario 'shows the basic information of a vendor including child databases' do
      visit "/admin/vendors/#{vendor.id}"
      expect(page).to have_content(vendor.name)
      expect(page).to have_content("Databases: (#{vendor.databases.count})")
      expect(page).to have_content(database.name)
      expect(page).to have_content(database.description) 
    end 
  end 
end