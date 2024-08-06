require "rails_helper"

RSpec.describe Public::BaseController, type: :routing do
  describe "landing pages" do
    it "/about/tests" do
      expect(:get => "/about/test").to route_to(
        :controller => "public/about", 
        :action => "index", 
        :uuid => "test"
      )
    end 
  end 
end
