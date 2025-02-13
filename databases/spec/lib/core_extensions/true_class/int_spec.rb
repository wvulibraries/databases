require 'rails_helper'

describe "CoreExtensions::TrueClass::Integer" do
  context ".to_i" do
    it "returns 0 for false" do
      expect(true.to_i).to eq 1
    end
  end
end