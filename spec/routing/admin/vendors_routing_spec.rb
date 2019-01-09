require "rails_helper"

RSpec.describe Admin::VendorsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/admin/vendors").to route_to("admin/vendors#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/vendors/new").to route_to("admin/vendors#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/vendors/1").to route_to("admin/vendors#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/vendors/1/edit").to route_to("admin/vendors#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/admin/vendors").to route_to("admin/vendors#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/vendors/1").to route_to("admin/vendors#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/vendors/1").to route_to("admin/vendors#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/vendors/1").to route_to("admin/vendors#destroy", :id => "1")
    end
  end
end
