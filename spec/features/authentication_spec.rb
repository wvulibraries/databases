require 'rails_helper'

describe 'Authentication' do
  it 'allows users to log in' do
    user = FactoryGirl.create(:user, password: 'password')
    get new_sessions_url
    fill_in 'email', with: user.email
    fill_in 'password', with: 'password'
    click_button 'Login'
    
    expect(current_url).to eq(dashboard_url)
    expect(page).to have_selector('.message', text: 'Welcome')
  end
# other examples ...
end