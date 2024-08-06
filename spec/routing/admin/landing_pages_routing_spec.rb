require "rails_helper"

RSpec.describe Admin::LandingPagesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/admin/landing_pages").to route_to("admin/landing_pages#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/landing_pages/new").to route_to("admin/landing_pages#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/landing_pages/1").to route_to("admin/landing_pages#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/landing_pages/1/edit").to route_to("admin/landing_pages#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/admin/landing_pages").to route_to("admin/landing_pages#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/landing_pages/1").to route_to("admin/landing_pages#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/landing_pages/1").to route_to("admin/landing_pages#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/landing_pages/1").to route_to("admin/landing_pages#destroy", :id => "1")
    end
  end
end
