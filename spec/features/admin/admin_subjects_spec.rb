require 'rails_helper'

RSpec.feature "Admin::Subjects", type: :feature do

  let(:subject) { FactoryBot.create(:subject) }
  let(:attrs) { FactoryBot.attributes_for(:subject) }
  let(:database) { FactoryBot.create(:database_basic) }

  context "#index" do
    scenario 'index page works and shows the data from the first record' do
      subject # create a database 
      visit 'admin/subjects'
      expect(page).to have_content(subject.name)
    end 
  end
  
  context "#create" do
    scenario 'successful create' do
      visit '/admin/subjects/new'
      fill_in 'Name', with: attrs[:name]
      click_button 'Create Subject'
      expect(page).to have_content( I18n.t('admin.basic.messages.created', model: 'subject'))
    end

    scenario 'failed without name' do
      visit '/admin/subjects/new'
      click_button 'Create Subject'
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content('Name is too short (minimum is 2 characters)')
      expect(page).to have_content('2 errors')
    end 
  end

  context '#update' do
    before :each do
      subject #instantiate
    end 

    scenario 'successful update' do
      visit "/admin/subjects/#{subject.id}/edit"
      fill_in 'Name', with: 'Changing the Name'
      click_button 'Update Subject'
      expect(page).to have_content(I18n.t('admin.basic.messages.updated', model: 'subject'))
    end

    scenario 'failing update name' do
      visit "/admin/subjects/#{subject.id}/edit"
      fill_in 'Name', with: ''
      click_button 'Update Subject'
      expect(page).to have_content("2 errors")
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Name is too short (minimum is 2 characters)")
    end 
  end 

  context '#delete' do
    before :each do
      subject # instantiate
    end 

    scenario 'deletes databases' do
      visit '/admin/subjects'
      click_link 'Delete'
      expect(page).to have_content( I18n.t('admin.basic.messages.deleted', model: 'subject'))
      expect(page).to_not have_content(subject.name)
    end
  end 

  context '#show' do
    before :each do
      subject
    end 

    scenario 'shows the basic information of a subject including child databases' do
      visit "/admin/subjects/#{subject.id}"
      expect(page).to have_content(subject.name)
    end 
  end 

  context '#curated' do
    before :each do
      @db_curated = FactoryBot.create(:database_curated, database: database, subject: subject)
    end 

    scenario 'shows the basic informaiton of a curated list' do
      visit '/admin/curated'
      expect(page).to have_content(@db_curated.subject_name)
      expect(page).to have_content(@db_curated.database_name)
      expect(page).to have_content(@db_curated.sort)
    end 
  end 

  context '#curated' do
    before :each do
      @db_curated = FactoryBot.create(:database_curated, database: database, subject: subject)
    end 

    scenario 'lets you update the sort order list' do
      visit "/admin/curated/#{subject.id}/sort"
      find('#sort_0').find(:xpath, 'option[1]').select_option
      click_button 'Update Sorting Order'
      expect(page).to have_content('Sort Order Updated')
    end 

  end 
end