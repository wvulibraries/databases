require 'rails_helper'

RSpec.describe Database, type: :model do
  let(:database) { FactoryBot.create :database }

  context 'validate required data' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:url_id) }
  end

  context 'enums' do
    it { should define_enum_for(:status).with(%i[undefined production development hidden]) }
  end

  context 'validates the length of the item' do
    it { should validate_length_of(:name).is_at_most(190) }
    it { should validate_length_of(:name).is_at_least(2) }
    it { should validate_length_of(:years_of_coverage).is_at_most(50) }
    it { should validate_length_of(:url_id).is_at_most(50) }
    it { should validate_length_of(:url_id).is_at_least(2) }
  end

  context 'validates uniqueness' do
    it { should validate_uniqueness_of(:url_id) }
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

  # For the Many-to-one relationship we are just using a belongs to.
  # Rails Quirk
  context 'belongs to' do
    it { should belong_to(:vendor) }
    it { should belong_to(:access_type) }
    it { should belong_to(:access_plain_text) }
  end

  context 'has_many associations' do
    it { should have_many(:resources) }
    it { should have_many(:subjects) }
    # it { should have_many(:curated) }
  end

  it 'factory bot is valid' do
    expect(database).to be_valid
  end

  context 'database url' do
    it 'expects invalid url' do
      database.url = 'soemthing'
      expect(database).to_not be_valid
      expect(database.errors.messages[:url]).to eq ['is not a valid URL']
    end

    it 'expects valid url' do
      database.url = Faker::Internet.url
      expect(database).to be_valid
    end 
  end

  context 'help url' do
    it 'expects invalid url' do
      database.help_url = 'soemthing'
      expect(database).to_not be_valid
      expect(database.errors.messages[:help_url]).to eq ['is not a valid URL']
    end

    it 'expects valid url ' do
      database.help_url = Faker::Internet.url
      expect(database).to be_valid
    end 
  end

  context 'off campus url' do
    it 'expects invalid url' do
      database.off_campus_url = 'soemthing'
      expect(database).to_not be_valid
      expect(database.errors.messages[:off_campus_url]).to eq ['is not a valid URL']
    end

    it 'expects valid url' do
      database.off_campus_url = Faker::Internet.url
      expect(database).to be_valid
    end
  end

  context 'status scopes' do
    it 'expects production status to eq 1' do
      database.status = 'production'
      database.save! 
      expect(Database.production.count).to eq 1
    end

    it 'expects production status to be 0 and hidden to be 1' do
      database.status = 'hidden'
      database.save!
      expect(Database.production.count).to eq 0
      expect(Database.hidden.count).to eq 1
    end

    it 'expects production status to be 0 and development to be 1' do
      database.status = 'development'
      database.save!
      expect(Database.production.count).to eq 0
      expect(Database.development.count).to eq 1
    end
  end

end
