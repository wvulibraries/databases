require 'rails_helper'

describe Admin::DatabasesController, type: :controller do
  describe "GET/index generate CSV" do
    before :each do
      get :index, format: :csv
    end
  
    it "generate CSV" do
      expect(response.header['Content-Type']).to include 'text/csv'
      expect(response.body).to include("Id,Name,Status,Years Of Coverage,Vendor Name,Url,Access,Full Text Db,New Database,Trial Database,Help,Help Url,Description,Url Uuid,Popular,Trial Database,Trial Expiration Date,Title Search,Resource List,Subject List,Created At,Updated At")
    end
  end
end