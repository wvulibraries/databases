require 'rails_helper'

RSpec.feature "Admin::Databases", type: :feature do
  let(:user) { FactoryBot.create(:user) }

  context "#index" do
    scenario 'index page works and shows the data from the first record' do
      page.set_rack_session(cas: { user: user.cas_username, email: user.cas_email, extra_attributes: { displayName: "#{user.first_name} #{user.last_name}" } })
      visit '/admin'
      expect(page).to have_content(user.first_name)
      expect(page).to have_content(user.last_name)
      expect(page).to have_content('Welcome to the admin panel for the LibDataBase application.')
    end
  end
end
