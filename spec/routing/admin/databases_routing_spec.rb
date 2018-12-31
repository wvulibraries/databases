require "rails_helper"

RSpec.describe Admin::DatabasesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/admin/databases").to route_to("admin/databases#index")
    end

    context "#list" do
      it "#list production" do
        expect(:get => "/admin/databases/list/production").to route_to(
          :controller => "admin/databases",
          :action => "list", 
          :status => "production"
        )
      end

      it "#list hidden" do
        expect(:get => "/admin/databases/list/hidden").to route_to(
          :controller => "admin/databases",
          :action => "list", 
          :status => "hidden"
        )
      end

      it "#list development" do
        expect(:get => "/admin/databases/list/development").to route_to(
          :controller => "admin/databases",
          :action => "list", 
          :status => "development"
        )
      end
    end 

    it "routes to #new" do
      expect(:get => "/admin/databases/new").to route_to("admin/databases#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/databases/1").to route_to("admin/databases#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/databases/1/edit").to route_to("admin/databases#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/admin/databases").to route_to("admin/databases#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/databases/1").to route_to("admin/databases#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/databases/1").to route_to("admin/databases#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/databases/1").to route_to("admin/databases#destroy", :id => "1")
    end
  end
end
