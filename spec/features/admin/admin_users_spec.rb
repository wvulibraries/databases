require 'rails_helper'

RSpec.feature "Admin::Users", type: :feature do

  let(:user) { FactoryBot.create(:user) }
  let(:attrs) { FactoryBot.attributes_for(:user) }

  context "#index" do
    scenario 'index page works and shows the data from the first record' do
      user # create a database
      visit 'admin/users'
      expect(page).to have_content(user.name)
      expect(page).to have_content(user.cas_username)
      expect(page).to have_content(user.cas_email)
    end
  end
  
  context "#create" do
    scenario 'successful create' do
      visit '/admin/users/new'
      fill_in 'First name', with: attrs[:first_name]
      fill_in 'Last name', with: attrs[:last_name]
      fill_in 'Email', with: attrs[:cas_email]
      fill_in 'Username', with: attrs[:cas_username]
      click_button 'Create User'
      expect(page).to have_content( I18n.t('admin.basic.messages.created', model: 'user'))
    end

    scenario 'failed to show errors' do
      visit '/admin/users/new'
      click_button 'Create User'
      expect(page).to have_content("First name can't be blank")
      expect(page).to have_content('First name is too short (minimum is 2 characters)')
      expect(page).to have_content("Last name can't be blank")
      expect(page).to have_content('Last name is too short (minimum is 2 characters)')
      expect(page).to have_content("Cas username can't be blank")
      expect(page).to have_content("Cas username is too short (minimum is 4 characters)")
      expect(page).to have_content("Cas email can't be blank")
      expect(page).to have_content("Cas email Email be a valid .edu email address.")
      expect(page).to have_content('8 errors')
    end
  end

  context '#update' do
    before :each do
      user #instantiate
    end

    scenario 'successful update' do
      visit "/admin/users/#{user.id}/edit"
      fill_in 'First name', with: 'Changing the Name'
      click_button 'Update User'
      expect(page).to have_content(I18n.t('admin.basic.messages.updated', model: 'user'))
    end

    scenario 'failing update name' do
      visit "/admin/users/#{user.id}/edit"
      fill_in 'First name', with: ''
      click_button 'Update User'
      expect(page).to have_content("2 errors")
      expect(page).to have_content("First name can't be blank")
      expect(page).to have_content("First name is too short (minimum is 2 characters)")
    end

    scenario 'failing update invalid email' do
      visit "/admin/users/#{user.id}/edit"
      fill_in 'Email', with: 'soemthingcool@google.com'
      click_button 'Update User'
      expect(page).to have_content("Cas email Email be a valid .edu email address.")
      expect(page).to have_content('1 error')
    end
  end

  context '#delete' do
    before :each do
      user # instantiate
    end

    scenario 'deletes databases' do
      visit '/admin/users'
      click_link 'Delete'
      expect(page).to have_content('Admin Users')
      expect(page).to have_content( I18n.t('admin.basic.messages.deleted', model: 'user'))
      expect(page).to_not have_content(user.name)
    end
  end

  context '#show' do
    before :each do
      user
    end

    scenario 'shows the basic information of a user including child databases' do
      visit "/admin/users/#{user.id}"
      expect(page).to have_content(user.name)
      expect(page).to have_content(user.cas_email)
      expect(page).to have_content(user.cas_username)
    end
  end
end