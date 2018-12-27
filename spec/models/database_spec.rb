require 'rails_helper'

RSpec.describe Database, type: :model do
  let(:database) { FactoryBot.create :database_basic }
  let(:vendor) { FactoryBot.create :vendor }

  context 'validate required data' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:description) }
    # it { should validate_presence_of(:url_uuid) }
  end

  context 'enums' do
    it { should define_enum_for(:status).with(%i[undefined production development hidden]) }
    it { should define_enum_for(:access).with ({'Campus Only Access (No Proxy)' => 1, 'Campus and Off Campus (Proxy)' => 2 }) }
  end

  context 'validates the length of the item' do
    it { should validate_length_of(:name).is_at_most(190) }
    it { should validate_length_of(:name).is_at_least(2) }
    it { should validate_length_of(:years_of_coverage).is_at_most(50) }
    it { should validate_length_of(:url_uuid).is_at_most(50) }
    it { should validate_length_of(:url_uuid).is_at_least(2) }
  end

  context 'validates uniqueness' do
    it { should validate_uniqueness_of(:url_uuid) }
  end 

  # You will get a shoulda warning that this is not fully validatable
  # https://github.com/thoughtbot/shoulda-matchers/issues/512#issuecomment-50213690
  # context 'boolean validations' do
  #   it { should validate_inclusion_of(:full_text_db).in_array([true, false]) }
  #   it { should validate_inclusion_of(:new_database).in_array([true, false]) }
  #   it { should validate_inclusion_of(:trial_database).in_array([true, false]) }
  #   it { should validate_inclusion_of(:popular).in_array([true, false]) }
  #   it { should validate_inclusion_of(:alumni).in_array([true, false]) }
  # end

  context 'belongs to' do
    it { should belong_to(:vendor) }
  end

  context 'has_many associations' do
    it { should have_many(:resources) }
    it { should have_many(:subjects) }
    it { should have_many(:curated) }
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

  context 'keywords and indexing' do
    it 'expects keywords to exist' do 
      expect(database.keywords.length).to be > 0
    end 

    it 'expects keywords has the title in it' do
      expect(database.keywords).to include database.name
    end

    it 'expects keywords to use the status' do
      expect(database.keywords).to include database.status
    end

    it 'expects keywords to use title_search' do
      expect(database.keywords).to include database.title_search
    end

    it 'expects keywords to use subject_list' do
      sub1 = FactoryBot.create :subject
      sub2 = FactoryBot.create :subject 
      database.subjects = [sub1, sub2]
      database.save
      expect(database.keywords).to include database.subject_list
    end 
  end

  context 'vendors' do
    it 'allows vendor to be added to database' do
      database.vendor = vendor
      expect(database).to be_valid
      database.save
      expect(database.vendor).to be_truthy
      expect(database.vendor.name).to eq(vendor.name)
    end

    it 'allows vendor to be nil' do
      database.vendor = nil
      expect(database).to be_valid
      database.save
      expect(database.vendor).to be_nil
    end
  end

  context 'subjects' do
    before(:each) do
      @sub1 = FactoryBot.create :subject
      @sub2 = FactoryBot.create :subject 
      @sub3 = FactoryBot.create :subject 
      database.subjects = [@sub1, @sub2, @sub3]
    end
   
    it 'expects database to be valid and have 3 subjects' do
      expect(database).to be_valid
      database.save
      expect(database.subjects.count).to eq 3 
    end 

    it 'expects database to send back a comma seperated sentance' do
      expect(database.subject_list).to include @sub1.name
      expect(database.subject_list).to include @sub2.name
      expect(database.subject_list).to include @sub3.name
    end 
  end

  context 'resources' do
    before(:each) do
      @rss1 = FactoryBot.create :resource
      @rss2 = FactoryBot.create :resource
      @rss3 = FactoryBot.create :resource
      database.resources = [@rss1, @rss2, @rss3]
    end
   
    it 'expects database to be valid and have 3 resources' do
      expect(database).to be_valid
      database.save
      expect(database.resources.count).to eq 3 
    end

    it 'expects database to send back a comma seperated sentance of resources' do
      expect(database.resource_list).to include @rss1.name
      expect(database.resource_list).to include @rss2.name
      expect(database.resource_list).to include @rss3.name
    end 
  end

  context 'create a url_uuid' do
    it 'expects a similar url_uuid to fail' do
      db2 = FactoryBot.create(:database_basic)
      expect(FactoryBot.build(:database)).to_not be_valid
    end 

    it 'expects the uuid to be created using callbacks' do
      expect(database.url_uuid).to be_truthy
    end 

    it 'expects the uuid will never be nil' do
      attrs = FactoryBot.attributes_for(:database_basic)
      attrs[:url_uuid] = nil
      db = Database.create(attrs)
      expect(db.url_uuid).to_not be_nil
    end 
  end 

  context 'creates default values for help' do
    it 'has a default help text' do
      db = FactoryBot.create(:database_default_values)
      expect(db.help).to eq 'Ask a Librarian'
    end 

    it 'has a default help url' do
      db = FactoryBot.create(:database_default_values)
      expect(db.help_url).to eq 'http://westvirginia.libanswers.com/'
    end 
  end  

  context 'creates a csv report' do
    it 'csv stuff' do
      database # init database
      databases = Database.all
      csv_string = databases.to_csv.to_s
      # attr to check
      attributes = %w{id name status years_of_coverage vendor url access full_text_db new_database trial_database access_plain_text help help_url description url_uuid popular trial_database trial_expiration_date title_search created_at updated_at}
      # run an expecatation for each attribute
      attributes.each do |attr| 
        expect(csv_string).to include database[attr].to_s
      end 
    end 
  end 
end
