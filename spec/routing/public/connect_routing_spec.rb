require "rails_helper"

RSpec.describe Public::BaseController, type: :routing do
  describe "connect" do
    it "/connect/tests" do
      expect(:get => "/connect/test").to route_to(
        :controller => "public/connect", 
        :action => "index", 
        :uuid => "test"
      )
    end
  end
end
