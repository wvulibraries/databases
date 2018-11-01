require 'rails_helper'

RSpec.describe DatabaseList, type: :model do
  let(:database_list) { FactoryBot.create :database_list }

  context 'validations' do
    it { should validate_length_of(:name).is_at_most(190) }
    it { should validate_length_of(:name).is_at_least(2) }
    it { should validate_length_of(:years_of_coverage).is_at_most(50) }
    it { should validate_length_of(:help).is_at_most(16777215) }
    it { should validate_length_of(:help_url).is_at_most(16777215) }
    it { should validate_length_of(:description).is_at_most(16777215) }
    it { should validate_length_of(:url_id).is_at_most(50) }
  end

  context 'numerical validations' do
    it { should validate_numericality_of(:full_text_db) }
    it { should validate_numericality_of(:new_database) }
    it { should validate_numericality_of(:trial_database) }
    it { should validate_numericality_of(:new_database) }
    it { should validate_numericality_of(:popular) }
    it { should validate_numericality_of(:alumni) }
  end 

  context 'has one associations' do
    it { should have_one(:status) }
    it { should have_one(:access) }
    it { should have_one(:acess_type) }
    it { should have_one(:vendor) }
  end 

  context 'has_many associations' do
    it { should have_many(:resource_types) }
    it { should have_many(:subjects) }
    it { should have_many(:curated) }
  end

  it 'expects address to be valid' do
    expect(address).to be_valid
  end

  describe '#human_readable' do
    it 'expects address to be human readable' do
      format = "#{address.line1} #{address.line2}, #{address.city}, #{address.state} #{address.zip}"
      expect(address.human_readable).to eq(format)
    end

    it 'expects a string value from the model' do
      expect(address.human_readable.class).to eq(String) 
    end
  end
end