require 'rails_helper'

RSpec.describe Statistics::CSV do
  context '.as_csv' do
    it 'should return csv file' do
      db1 = FactoryBot.create :link_tracking_rspec
      db2 = FactoryBot.create :link_tracking_rspec
      params_hash = { 
        start_date: Time.now.to_s, 
        end_date: 1.year.from_now.to_s  
      }
      base = described_class.new(params_hash)
      result = base.as_csv
      expect(result.count("\n")).to eq(3)
    end
  end
end