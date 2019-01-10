require 'rails_helper'

RSpec.feature "Admin::resources", type: :feature do

  let(:resource) { FactoryBot.create(:resource) }
  let(:attrs) { FactoryBot.attributes_for(:resource) }
  let(:database) { FactoryBot.create(:database_basic) }

  context "#index" do
    scenario 'index page works and shows the data from the first record' do
      resource # create a database 
      visit 'admin/resources'
      expect(page).to have_content(resource.name)
    end 
  end
  
  context "#create" do
    scenario 'successful create' do
      visit '/admin/resources/new'
      fill_in 'Name', with: attrs[:name]
      click_button 'Create Resource'
      expect(page).to have_content( I18n.t('admin.basic.messages.created', model: 'Resource'))
    end

    scenario 'failed without name' do
      visit '/admin/resources/new'
      click_button 'Create Resource'
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content('Name is too short (minimum is 2 characters)')
      expect(page).to have_content('2 errors')
    end 
  end

  context '#update' do
    before :each do
      resource #instantiate
    end 

    scenario 'successful update' do
      visit "/admin/resources/#{resource.id}/edit"
      fill_in 'Name', with: 'Changing the Name'
      click_button 'Update Resource'
      expect(page).to have_content(I18n.t('admin.basic.messages.updated', model: 'Resource'))
    end

    scenario 'failing update name' do
      visit "/admin/resources/#{resource.id}/edit"
      fill_in 'Name', with: ''
      click_button 'Update Resource'
      expect(page).to have_content("2 errors")
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Name is too short (minimum is 2 characters)")
    end 
  end 

  context '#delete' do
    before :each do
      resource # instantiate
    end 

    scenario 'deletes databases' do
      visit '/admin/resources'
      click_link 'Delete'
      expect(page).to have_content('Resources')
      expect(page).to have_content( I18n.t('admin.basic.messages.deleted', model: 'resource'))
      expect(page).to_not have_content(resource.name)
    end
  end 

  context '#show' do
    before :each do
      resource
    end 

    scenario 'shows the basic information of a resource including child databases' do
      visit "/admin/resources/#{resource.id}"
      expect(page).to have_content(resource.name)
    end 
  end 
end