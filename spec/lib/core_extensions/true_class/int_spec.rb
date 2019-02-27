require 'rails_helper'

describe "TrueClass::Integer" do
  context ".to_i" do
    it "returns 0 for false" do
      expect(true.to_i).to eq 1
    end
  end
end