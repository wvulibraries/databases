require 'rails_helper'

RSpec.describe Statistics::Base, type: :model do
  context '.init' do
    it '@start_date' do
      params_hash = { 
        start_date: Date.today.to_s, 
        end_date: 1.year.from_now.to_s 
      }
      base = described_class.new(params_hash)
      expect(base.instance_variable_defined?(:@start_date)).to be true
    end

    it '@end_date' do
      params_hash = { 
        start_date: Date.today.to_s, 
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
        start_date: Date.today.to_s, 
        end_date: 1.year.from_now.to_s 
      }
      base = described_class.new(params_hash)
      expect(base.valid?).to be true    
    end

    it 'should return false on invalid dates' do
      params_hash = { 
        start_date: Date.today.to_s, 
        end_date: 'I am not a date'   
      }
      base = described_class.new(params_hash)
      expect(base.valid?).to be false    
    end    
  end

  context '.perform_query' do
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