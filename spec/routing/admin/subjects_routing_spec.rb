require "rails_helper"

RSpec.describe Admin::SubjectsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/admin/subjects").to route_to("admin/subjects#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/subjects/new").to route_to("admin/subjects#new")
    end

    it "routes to #edit" do
      expect(:get => "/admin/subjects/1/edit").to route_to("admin/subjects#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/subjects").to route_to("admin/subjects#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/subjects/1").to route_to("admin/subjects#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/subjects/1").to route_to("admin/subjects#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/subjects/1").to route_to("admin/subjects#destroy", :id => "1")
    end

    it "routes to a list of curated subjects" do
      expect(:get => '/admin/curated').to route_to("admin/subjects#curated")
    end 

    it "routes to a form for sorting curated subjects" do
      expect(:get => 'admin/curated/1/sort').to route_to("admin/subjects#sort", :subject => "1")
    end 
    
    it "accepts the post for curation or sort order" do
      expect(:post => 'admin/curated').to route_to("admin/subjects#update_curated")
    end 
  end
end
