require 'rails_helper'

RSpec.feature "Admin::Subjects", type: :feature do

  let(:database) { FactoryBot.attributes_for(:databases) }

  before(:each) do
    new_subject
  end

  scenario 'subjects index page and it works properly' do
    visit '/admin/subjects'
    expect(page).to have_content('Manage Subjects')
  end

  scenario 'creates a new subject' do
    visit '/admin/subjects/new'
    fill_in 'Name', with: subject[:name]
    click_button 'Create Subject'
    expect(page).to have_content('Success! We built a brand new subject!')
  end

  scenario 'errors creating new subject' do
    visit '/admin/subjects/new'
    fill_in 'Name', with: 'te' # must be 3 chars
    click_button 'Create Subject'
    expect(page).to have_content('1 error')
    expect(page).to have_content('Name is too short (minimum is 3 characters)')
  end

  scenario 'updates an existing subject' do
    visit "/admin/subjects/#{new_subject.id}/edit"
    fill_in 'Name', with: 'Changing the Name'
    click_button 'Update Subject'
    expect(page).to have_content('Success! We have edited the subject!')
  end

  scenario 'errors an existing subject' do
    visit "/admin/subjects/#{new_subject.id}/edit"
    fill_in 'Name', with: 'te' # must be 3 chars
    click_button 'Update Subject'
    expect(page).to have_content('1 error')
    expect(page).to have_content('Name is too short (minimum is 3 characters)')
  end

  scenario 'deletes an existing building' do
    visit '/admin/subjects'
    click_link 'Destroy'
    expect(page).to have_content('Manage Subjects')
    expect(page).to have_content('Demolition Success! We destroyed the subject!')
    expect(page).to_not have_content(new_subject.name)
  end
end