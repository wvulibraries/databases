require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create :user }

  context 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_length_of(:first_name).is_at_least(2) }
    it { should validate_length_of(:first_name).is_at_most(70) }

    it { should validate_presence_of(:last_name) }
    it { should validate_length_of(:last_name).is_at_least(2) }
    it { should validate_length_of(:last_name).is_at_most(70) }

    it { should validate_presence_of(:cas_email) }

    it { should validate_presence_of(:cas_username) }
    it { should validate_length_of(:cas_username).is_at_least(4) }
    it { should validate_length_of(:cas_username).is_at_most(100) }
  end 

  context '.valid_email' do
    it 'valid factory base level' do
      expect(user).to be_valid
    end 
 
    it 'expects any .edu to be valid' do
      user.cas_email = 'jjonas@wvu.edu' 
      expect(user).to be_valid 
      user.cas_email = 'apples@mail.cmu.edu'
      expect(user).to be_valid 
      user.cas_email = 'a.j.abrams@retired.mu.edu'
      expect(user).to be_valid  
    end 

    it 'expects any non .edu to be invalid' do
      user.cas_email = 'jjonas@wvu.com' 
      expect(user).to_not be_valid 
      user.cas_email = 'apples@mail.cmu.net'
      expect(user).to_not be_valid 
      user.cas_email = 'a.j.abrams@retired.mu.something'
      expect(user).to_not be_valid  
    end 


    it 'expects email to be invalid as anything, but .edu at the end' do
      user.cas_email = Faker::Internet.email
      expect(user).to_not be_valid
      expect(user.errors.messages[:cas_email]).to eq ['Email be a valid .edu email address.']
    end
  end

  context '.name' do
    it 'returns string' do
      expect(user.name).to be_a(String)
    end 

    it 'expects it to be a cancatenation of first and last name' do
      expect(user.name).to eq ("#{user.first_name} #{user.last_name}")
    end 
  end 
end
