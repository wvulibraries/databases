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
      expect(response.body).to include("DATABASE NAME,PUBLIC DATABASE DISPLAY,DATABASE LANDING PAGE,DATABASE URL,USE PROXY?,FRIENDLY URL,DATABASE LANDING PAGE FRIENDLY URL,ALTERNATE NAMES,KEYWORDS & MISSPELLINGS,DATABASE DESCRIPTION,VENDOR,TYPES,ASSOCIATED SUBJECTS,BEST BETS,ATTRIBUTES,FLAGS,THUMBNAIL URL,THUMBNAIL ALT TEXT,MORE INFO,LIBRARIAN REVIEW,INTERNAL NOTE,ACCESS MODES,OWNER,RESOURCE ICONS,PERMITTED USES")
    end
  end

end