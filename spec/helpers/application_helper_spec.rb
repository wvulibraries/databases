require 'rails_helper'

describe ApplicationHelper do
  describe "#is_number?" do
    it "returns true is a number" do
      expect(helper.is_number?('10')).to be true
    end
    it 'returns false not a number' do
      expect(helper.is_number?('something')).to be false
    end 
    it 'returns true for an actual int' do
      expect(helper.is_number?(10)).to be true
    end 
    it 'returns false for nil' do
      expect(helper.is_number?(nil)).to be false
    end 
  end
end