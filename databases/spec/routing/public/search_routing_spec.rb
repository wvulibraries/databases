require "rails_helper"

RSpec.describe Public::SearchController, type: :routing do
  describe "search routes" do
    it "/search" do
      expect(:get => "/search").to route_to(
        :controller => "public/search", 
        :action => "index"
      )
    end 

    it "/search with query" do
      expect(:get => "/search?query='testing'").to route_to(
        :controller => "public/search", 
        :action => "index",
        :query => "'testing'"
      )
    end 

    it "/search/1 with page" do
      expect(:get => "/search/1?query='testing'").to route_to(
        :controller => "public/search", 
        :action => "index",
        :query => "'testing'", 
        :page => '1'
      )
    end 
  end 
end