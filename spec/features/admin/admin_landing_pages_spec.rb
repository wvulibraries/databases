require 'rails_helper'

RSpec.feature "Admin::LandingPages", type: :feature do

  let(:landing_page) { FactoryBot.create(:landing_page) }
  let(:landing_page_attr) { FactoryBot.attributes_for(:landing_page) }
  let(:database) { FactoryBot.create(:database_basic) }

  context "#index" do
    scenario 'index page works and shows the data from the first record' do
      landing_page # create a database 
      visit 'admin/landing_pages'
      expect(page).to have_content(landing_page.contact_name)
    end 
  end
  
  context "#create" do
    scenario 'successful create' do
      visit '/admin/landing_pages/new'
      fill_in 'Name', with: landing_page_attr[:contact_name]
      fill_in 'Email', with: landing_page_attr[:contact_email]
      fill_in 'Phone Number', with: landing_page_attr[:contact_phone_number]
      fill_in 'Title', with: landing_page_attr[:contact_title]
      fill_in 'Instructions', with: landing_page_attr[:instructions]
      click_button 'Create Landing page'
      expect(page).to have_content(I18n.t('admin.basic.messages.created', model: 'Landing Page'))
    end

    scenario 'failed providing no content, should have all the following errors' do
      visit '/admin/landing_pages/new'
      click_button 'Create Landing page'
      expect(page).to have_content("Instructions can't be blank")
      expect(page).to have_content("Contact name can't be blank")
      expect(page).to have_content("Contact email can't be blank")
      expect(page).to have_content("Contact phone number can't be blank")
      expect(page).to have_content("Contact title can't be blank")
      expect(page).to have_content("5 errors")
    end 
  end

  context '#update' do
    before :each do
      landing_page #instantiate
    end 

    scenario 'successful update' do
      visit "/admin/landing_pages/#{landing_page.id}/edit"
      fill_in 'Name', with: 'Changing the Name'
      click_button 'Update Landing page'
      expect(page).to have_content(I18n.t('admin.basic.messages.updated', model: 'Landing Page'))
    end

    scenario 'failing update name' do
      visit "/admin/landing_pages/#{landing_page.id}/edit"
      fill_in 'Name', with: ''
      click_button 'Update Landing page'
      expect(page).to have_content("Contact name can't be blank")
    end 
  end 

  context '#delete' do
    before :each do
      landing_page #instantiate
    end 

    scenario 'deletes databases' do
      visit '/admin/landing_pages'
      expect(page).to have_content(landing_page.contact_name)
      click_link 'Delete'
      expect(page).to have_content('Landing Pages')
      expect(page).to have_content( I18n.t('admin.basic.messages.deleted', model: 'Landing Page'))
      expect(page).to_not have_content(landing_page.contact_name)
    end
  end 

  context '#show' do
    before :each do
      landing_page #instantiate
      landing_page.database = database
      landing_page.save!
    end 

    scenario 'preview of the page' do
      visit "/admin/landing_pages/#{landing_page.id}"
      expect(page).to have_content('This is a preview of the landing page without branded styles.')
      expect(page).to have_content(database.name)
      expect(page).to have_content(database.description) 
      expect(page).to have_content(landing_page.instructions)
      expect(page).to have_content(landing_page.contact_name)
      expect(page).to have_content(landing_page.contact_title)
      expect(page).to have_content(landing_page.contact_phone_number)
      expect(page).to have_content(landing_page.contact_email)
    end 
  end 
end