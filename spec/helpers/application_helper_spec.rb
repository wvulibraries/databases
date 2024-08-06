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
  describe "#title" do
    it "should return the supplied block if a block was given" do
      helper.title ( "Some Block" )
      expect(helper.content_for(:title)).to eq "Databases | Some Block"
    end
  end
end