require "rails_helper"

RSpec.describe Public::BaseController, type: :routing do
  describe "root" do
    it "/" do
      expect(:get => "/").to route_to("public/base#index")
    end
  end

  describe "AtoZ" do
    it "alphabetical list" do
      expect(:get => "/AtoZ").to route_to("public/base#all")
    end

    it "list of databases by letter" do
      expect(:get => "/AtoZ/a").to route_to(
        :controller => "public/base", 
        :action => "a_to_z", 
        :character => "a"
      )
    end
  end 

  describe "Subjects" do
    it "/subject" do
      expect(:get => "/subject").to route_to("public/base#subject")
    end

    it "/subjects" do
      expect(:get => "/subjects").to route_to("public/base#subject")
    end

    # it "/databases/subjects" do
    #   expect(:get => "/databases/subjects").to redirect_to('/subjects')
    # end

    it "/subject/1" do
      expect(:get => "/subject/1").to route_to(
        :controller => "public/base", 
        :action => "subject_databases", 
        :id => "1"
      )
    end
  end 
end
