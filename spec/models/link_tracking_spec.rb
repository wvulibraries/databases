require 'rails_helper'

RSpec.describe LinkTracking, type: :model do
  let(:link_tracking) { FactoryBot.create(:link_tracking_database_association) }
 
  context 'validate required data' do
    it { should validate_presence_of(:ip_address) }
    it { should validate_length_of(:ip_address).is_at_least(7).is_at_most(15) }
    it { should validate_presence_of(:database) }
  end  

  context 'belongs to' do
    it { should belong_to(:database) }
  end  
end
