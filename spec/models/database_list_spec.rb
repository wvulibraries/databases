require 'rails_helper'

RSpec.describe DatabaseList, type: :model do
  let(:database_list) { FactoryBot.create :database_list }

  context 'validate required data' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:description) }
  end

  context 'enums' do
    it { should define_enum_for(:status).with(%i[undefined production development hidden]) }
  end

  context 'validates the length of the item' do
    it { should validate_length_of(:name).is_at_most(190) }
    it { should validate_length_of(:name).is_at_least(2) }
    it { should validate_length_of(:years_of_coverage).is_at_most(50) }
    it { should validate_length_of(:url_id).is_at_most(50) }
  end

  # You will get a shoulda warning that this is not fully validatable
  # https://github.com/thoughtbot/shoulda-matchers/issues/512#issuecomment-50213690
  context 'boolean validations' do
    it { should validate_inclusion_of(:full_text_db).in_array([true, false]) }
    it { should validate_inclusion_of(:new_database).in_array([true, false]) }
    it { should validate_inclusion_of(:trial_database).in_array([true, false]) }
    it { should validate_inclusion_of(:popular).in_array([true, false]) }
    it { should validate_inclusion_of(:alumni).in_array([true, false]) }
  end
  
  context 'belongs to' do
    it { should belong_to(:vendor) }
  end 


  context 'has one associations' do
    # it { should have_one(:access) }
    # it { should have_one(:acess_type) }
  end

  # context 'has_many associations' do
  #   it { should have_many(:resource_types) }
  #   it { should have_many(:subjects) }
  #   it { should have_many(:curated) }
  # end

  it 'factory bot is valid' do
    expect(database_list).to be_valid
  end

  context 'database url' do
    it 'expects invalid url' do
      database_list.url = 'soemthing'
      expect(database_list).to_not be_valid
      expect(database_list.errors.messages[:url]).to eq ['is not a valid URL']
    end

    it 'expects valid url' do
      database_list.url = Faker::Internet.url
      expect(database_list).to be_valid
    end 
  end

  context 'help url' do
    it 'expects invalid url' do
      database_list.help_url = 'soemthing'
      expect(database_list).to_not be_valid
      expect(database_list.errors.messages[:help_url]).to eq ['is not a valid URL']
    end

    it 'expects valid url ' do
      database_list.help_url = Faker::Internet.url
      expect(database_list).to be_valid
    end 
  end

  context 'off campus url' do
    it 'expects invalid url' do
      database_list.off_campus_url = 'soemthing'
      expect(database_list).to_not be_valid
      expect(database_list.errors.messages[:off_campus_url]).to eq ['is not a valid URL']
    end

    it 'expects valid url' do
      database_list.off_campus_url = Faker::Internet.url
      expect(database_list).to be_valid
    end 
  end

end
