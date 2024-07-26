require 'rails_helper'

describe Admin::DatabasesController, type: :controller do
  describe "GET/index generate CSV" do
    before :each do
      get :index, format: :csv
    end
  
    it "generate CSV" do
      expect(response.header['Content-Type']).to include 'text/csv'
      expect(response.body).to include("Id,Libguides Id,Name,Status,Years Of Coverage,Vendor Name,Url,Access,Full Text Db,Help,Help Url,Description,Url Uuid,New Database,Popular,Trial Database,Trial Expiration Date,Title Search,Subjects Column,Resources Column,Created At,Updated At")
    end
  end

  describe "/libguides.csv" do
    before :each do 
      get :lib_guides, format: :csv
    end

    it 'generates a csv' do
      expect(response.header['Content-Type']).to include 'text/csv'
    end

    it 'creates a properly formed csv file' do
      expect(response.body).to include("vendor,name,url,enable_proxy,description,more_info,enable_new,enable_trial,types,keywords,target,slug,best_bets,subjects,desc_pos,lib_note,enable_popular,enable_hidden,internal_note,owner,resource_icons,thumbnail,content_id")
    end
  end

end