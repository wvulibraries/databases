require 'rails_helper'
require 'active_support/testing/time_helpers'

RSpec.describe Statistics::Base do
  include ActiveSupport::Testing::TimeHelpers
  let(:linktracking) { FactoryBot.create :link_tracking_rspec  }

  context '.init' do
    it '@start_date' do
      params_hash = { 
        start_date: Time.now.to_s, 
        end_date: 1.year.from_now.to_s 
      }
      base = described_class.new(params_hash)
      expect(base.instance_variable_defined?(:@start_date)).to be true
    end

    it '@end_date' do
      params_hash = { 
        start_date: Time.now.to_s, 
        end_date: 1.year.from_now.to_s 
      }
      base = described_class.new(params_hash)
      expect(base.instance_variable_defined?(:@end_date)).to be true
    end 
  end

  context '.valid_date' do
    it 'should return true on valid date' do
      base = described_class.new
      expect(base.valid_date(Date.today.to_s)).to be true
    end    

    it 'should return false on invalid date' do
      base = described_class.new
      expect(base.valid_date('I am not a date')).to be false
    end    
  end

  context '.valid?' do
    it 'should return true on valid dates' do
      params_hash = { 
        start_date: Time.now.to_s, 
        end_date: 1.year.from_now.to_s 
      }
      base = described_class.new(params_hash)
      expect(base.valid?).to be true    
    end

    it 'should return false on invalid dates' do
      params_hash = { 
        start_date: Time.now.to_s,
        end_date: 'I am not a date'   
      }
      base = described_class.new(params_hash)
      expect(base.valid?).to be false    
    end    
  end

  
  # Changed test to freeze time with `travel_to` so created_at values are consistent.
  # This ensures the start/end date range is fixed and avoids failures caused by
  # real-time clock differences during the test.

  context '.perform_query' do
    it 'should return objects' do
      now = Time.zone.parse('2025-01-15 12:00:00')
      travel_to now do
        # define the window first
        start_s = (now - 1.day).iso8601
        end_s   = (now + 1.day).iso8601

        # create rows inside the window
        FactoryBot.create(:link_tracking_rspec, created_at: now - 1.hour)
        FactoryBot.create(:link_tracking_rspec, created_at: now)

        base   = described_class.new(start_date: start_s, end_date: end_s)
        result = base.perform_query
        expect(result.to_a.count).to eq(2)
      end
    end

    it 'should pass an exception' do
      params_hash = { 
        start_date: Date.today.to_s, 
        end_date: 'I am not a date'  
      }
      base = described_class.new(params_hash)
      expect{ base.perform_query }.to raise_error(StandardError, "Improper Dates, Date is not valid.")
    end
  end
  
end