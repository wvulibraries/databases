require 'rails_helper'

RSpec.feature "Admin::Databases", type: :feature do

  let(:database) { FactoryBot.create(:database_basic) }
  let(:attrs) { FactoryBot.attributes_for(:database_basic) }

  context "#index" do
    scenario 'index page works and shows the data from the first record' do
      database # create a database 
      visit 'admin/databases'
      expect(page).to have_content(database.name)
      expect(page).to have_content(database.vendor_name)
      expect(page).to have_content(database.status) 
    end 
  end

  context "#list" do
    scenario 'all' do
      database # create a database 
      visit 'admin/databases/list'
      expect(page).to have_content(database.name)
      expect(page).to have_content(database.vendor_name)
      expect(page).to have_content(database.status) 
    end 
    
    scenario 'hidden' do
      # set database to hidden 
      database.status = 'hidden'
      database.save! 
      # set another database, but not to hidden for comparison
      attrs[:status] = "production"
      db2 = Database.create(attrs)
      # visit the page and expect to see just that one
      visit 'admin/databases/list/hidden'
      expect(page).to have_content(database.name)
      expect(page).to have_content(database.url)
      expect(page).to have_content(database.vendor_name)
      expect(page).to have_content(database.subject_list)
      # comparison stuff 
      expect(page).to_not have_content(db2.name) 
    end 

    scenario 'production' do
      # set database
      database.status = 'production'
      database.save! 
      # set another database
      attrs[:status] = "hidden"
      db2 = Database.create(attrs)
      # visit the page and expect to see just that one
      visit 'admin/databases/list/production'
      expect(page).to have_content(database.name)
      expect(page).to have_content(database.url)
      expect(page).to have_content(database.vendor_name)
      expect(page).to have_content(database.subject_list)
      # comparison stuff 
      expect(page).to_not have_content(db2.name) 
    end
    
    scenario 'development' do
      # set database
      database.status = 'development'
      database.save! 
      # set another database
      attrs[:status] = "hidden"
      db2 = Database.create(attrs)
      # visit the page and expect to see just that one
      visit 'admin/databases/list/development'
      expect(page).to have_content(database.name)
      expect(page).to have_content(database.url)
      expect(page).to have_content(database.vendor_name)
      expect(page).to have_content(database.subject_list)
      # comparison stuff 
      expect(page).to_not have_content(db2.name) 
    end
  end

  context "#tables" do
    scenario 'all' do
      # instantiate database
      database.save! 
      # set another database, but not to hidden for comparison
      attrs[:status] = "production"
      db2 = Database.create(attrs)
      # visit the page and expect to see just that one
      visit 'admin/databases/tables'
      expect(page).to have_content(database.name)
      expect(page).to have_content(database.vendor_name)
      expect(page).to have_content(database.status)
      # comparison stuff 
      expect(page).to have_content(db2.name)
      expect(page).to have_content(db2.vendor_name)
      expect(page).to have_content(db2.status)
    end 

    scenario 'hidden' do
      # set database to hidden 
      database.status = 'hidden'
      database.save! 
      # set another database, but not to hidden for comparison
      attrs[:status] = "production"
      db2 = Database.create(attrs)
      # visit the page and expect to see just that one
      visit 'admin/databases/tables/hidden'
      expect(page).to have_content(database.name)
      expect(page).to have_content(database.vendor_name)
      expect(page).to have_content(database.status)
      # comparison stuff 
      expect(page).to_not have_content(db2.name)
      expect(page).to_not have_content(db2.status)
    end 

    scenario 'production' do
      # set database
      database.status = 'production'
      database.save! 
      # set another database
      attrs[:status] = "hidden"
      db2 = Database.create(attrs)
      # visit the page and expect to see just that one
      visit 'admin/databases/tables/production'
      expect(page).to have_content(database.name)
      expect(page).to have_content(database.vendor_name)
      expect(page).to have_content(database.status)
      # comparison stuff 
      expect(page).to_not have_content(db2.name)
      expect(page).to_not have_content(db2.status)
    end
    
    scenario 'development' do
      # set database
      database.status = 'development'
      database.save! 
      # set another database
      attrs[:status] = "hidden"
      db2 = Database.create(attrs)
      # visit the page and expect to see just that one
      visit 'admin/databases/tables/development'
      expect(page).to have_content(database.name)
      expect(page).to have_content(database.vendor_name)
      expect(page).to have_content(database.status)
      # comparison stuff 
      expect(page).to_not have_content(db2.name)
      expect(page).to_not have_content(db2.status)
    end
  end

  context "#create" do
    scenario 'successful create' do
      visit '/admin/databases/new'
      fill_in 'Title', with: attrs[:name]
      find('#database_status').find(:xpath, 'option[3]').select_option
      fill_in 'Url', with: attrs[:url]
      fill_in 'Description', with: attrs[:description]
      click_button 'Create Database'
      expect(page).to have_content(I18n.t('admin.databases.controllers.new'))
    end

    scenario 'does not allow creation without title' do
      visit '/admin/databases/new'
      fill_in 'Title', with: ''
      find('#database_status').find(:xpath, 'option[3]').select_option
      fill_in 'Url', with: attrs[:url]
      fill_in 'Description', with: attrs[:description]
      click_button 'Create Database'
      expect(page).to have_content("2 errors")
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Name is too short (minimum is 2 characters)")
    end 

    scenario 'does not allow years of coverage to be more than 50 characters' do
      visit '/admin/databases/new'
      fill_in 'Title', with: attrs[:name]
      find('#database_status').find(:xpath, 'option[3]').select_option
      fill_in 'Url', with: attrs[:url]
      fill_in 'Description', with: attrs[:description]
      fill_in 'Years of coverage', with: Faker::Lorem.characters(55)
      click_button 'Create Database'
      expect(page).to have_content("1 error")
      expect(page).to have_content("Years of coverage is too long (maximum is 50 characters)")
    end 

    scenario 'does not allow valid database without url' do
      visit '/admin/databases/new'
      fill_in 'Title', with: attrs[:name]
      find('#database_status').find(:xpath, 'option[3]').select_option
      fill_in 'Url', with: ''
      fill_in 'Description', with: attrs[:description]
      click_button 'Create Database'
      expect(page).to have_content("2 errors")
      expect(page).to have_content("Url is not a valid URL")
      expect(page).to have_content("Url can't be blank")
    end
    
    scenario 'does not allow an empty description' do
      visit '/admin/databases/new'
      fill_in 'Title', with: attrs[:name]
      find('#database_status').find(:xpath, 'option[3]').select_option
      fill_in 'Url', with: attrs[:url]
      fill_in 'Description', with: ''
      click_button 'Create Database'
      expect(page).to have_content("1 error")
      expect(page).to have_content("Description can't be blank")
    end 
  end

  context '#update' do
    before :each do
      database # instantiate a database
    end 

    scenario 'successful update' do
      visit "/admin/databases/#{database.id}/edit"
      fill_in 'Title', with: 'Changing the Name'
      click_button 'Update Database'
      expect(page).to have_content(I18n.t('admin.databases.controllers.update'))
    end

    scenario 'failing update' do
      visit "/admin/databases/#{database.id}/edit"
      fill_in 'Title', with: ''
      click_button 'Update Database'
      expect(page).to_not have_content(I18n.t('admin.databases.controllers.update'))
      expect(page).to have_content("2 errors")
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Name is too short (minimum is 2 characters)")
    end 
  end 

  context '#delete' do
    before :each do
      database # instantiate a database
    end

    scenario 'deletes databases' do
      visit '/admin/databases'
      click_link 'delete'
      expect(page).to have_content('Database List')
      expect(page).to have_content(I18n.t('admin.databases.controllers.delete'))
      expect(page).to_not have_content(database.name)
    end
  end

  context 'Importing' do
    scenario 'shows the import page' do
      visit '/admin/import'
      expect(page).to have_content('Database Import')
      expect(page).to have_content('Database CSV')
    end

    scenario 'performs a csv upload' do
      visit '/admin/import'
      expect(page).to have_content('Database Import')
      attach_file("Csv", "#{Rails.root}/spec/support/files/databases-auto-import.csv")
      click_button 'Import Now'
      expect(page.text).to have_content('Import Complete')
    end

    scenario 'performs a failing import' do
      # complete the import once
      visit '/admin/import'
      expect(page).to have_content('Database Import')
      attach_file("Csv", "#{Rails.root}/spec/support/files/databases-auto-import.csv")
      click_button 'Import Now'
      expect(page.text).to have_content('Import Complete')
      # then run the import again which will cause a failure because of
      # duplicate content
      visit '/admin/import'
      expect(page).to have_content('Database Import')
      attach_file("Csv", "#{Rails.root}/spec/support/files/databases-auto-import.csv")
      click_button 'Import Now'
      expect(page.text).to have_content('Error:')
    end
  end
end