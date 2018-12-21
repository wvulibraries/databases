require 'rails_helper'

RSpec.feature "Admin::Databases", type: :feature do

  let(:database) { FactoryBot.create(:database) }
  let(:attrs) { FactoryBot.attributes_for(:database) }

  context "#index" do
    scenario 'index page works and shows the data from the first record' do
      database # create a database 
      visit 'admin/databases'
      expect(page).to have_content(database.name)
    end 
  end

  context "CREATE" do
    scenario 'successful create' do
      visit '/admin/databases/new'
      fill_in 'Title', with: attrs[:name]
      find('#database_status').find(:xpath, 'option[3]').select_option
      fill_in 'Url', with: attrs[:url]
      fill_in 'Url', with: attrs[:help_url]
      fill_in 'Description', with: attrs[:description]
      click_button ''
      expect(page).to have_content(I18n.t('admin.databases.controllers.new'))
    end

    scenario 'does not allow creation without title' do
      pending 
    end 

    scenario 'does not allow creation without a valid unique url_id' do
      pending 
    end 

    scenario 'does not allow years of coverage to be more than 50 characters' do
      pending
    end 

    scenario 'does not allow valid database without url' do
      pending
    end
    
    scenario 'does not allow an empty description' do
      pending
    end 
  end  


  # scenario 'errors creating new subject' do
  #   visit '/admin/subjects/new'
  #   fill_in 'Name', with: 'te' # must be 3 chars
  #   click_button 'Create Subject'
  #   expect(page).to have_content('1 error')
  #   expect(page).to have_content('Name is too short (minimum is 3 characters)')
  # end

  # scenario 'updates an existing subject' do
  #   visit "/admin/subjects/#{new_subject.id}/edit"
  #   fill_in 'Name', with: 'Changing the Name'
  #   click_button 'Update Subject'
  #   expect(page).to have_content('Success! We have edited the subject!')
  # end

  # scenario 'errors an existing subject' do
  #   visit "/admin/subjects/#{new_subject.id}/edit"
  #   fill_in 'Name', with: 'te' # must be 3 chars
  #   click_button 'Update Subject'
  #   expect(page).to have_content('1 error')
  #   expect(page).to have_content('Name is too short (minimum is 3 characters)')
  # end

  # scenario 'deletes an existing building' do
  #   visit '/admin/subjects'
  #   click_link 'Destroy'
  #   expect(page).to have_content('Manage Subjects')
  #   expect(page).to have_content('Demolition Success! We destroyed the subject!')
  #   expect(page).to_not have_content(new_subject.name)
  # end
end