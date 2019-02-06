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


  describe "#campus_ip?" do
    it "on campus" do
      test_ip = IPAddr.new('157.182.3.19')
      expect(helper.campus_ip?(test_ip)).to be true
    end
    it "off campus" do
      test_ip = IPAddr.new('241.232.3.19')
      expect(helper.campus_ip?(test_ip)).to be false
    end
  end
end