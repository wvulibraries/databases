require 'rails_helper'

describe "FalseClass::Integer" do
  context ".to_i" do
    it "returns 0 for false" do
      expect(false.to_i).to eq 0
    end
  end
end