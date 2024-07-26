require 'rails_helper'

describe Admin::StatisticsController, type: :controller do
  describe "/stats" do
    before :each do 
      get :show_all
    end

    it 'generates a csv' do
      expect(response.header['Content-Type']).to include 'text/csv'
    end

    it 'creates a properly formed csv file' do
      expect(response.body).to include("name,count")
    end
  end 

  describe '/stats/:start_date/:end_date' do
    it 'generates a complete stats csv export' do
      get :show, params: { start_date: Date.today.to_s, end_date: 1.year.from_now.to_s }
      expect(response.header['Content-Type']).to include 'text/csv'
    end

    it 'creates a properly formed csv file' do
      get :show, params: { start_date: Date.today.to_s, end_date: 1.year.from_now.to_s }
      expect(response.body).to include("name,count")
    end    

    it 'redirects to link_tracking on invalid date' do
      get :show, params: { start_date: Date.today.to_s, end_date: 'I am not a date string' }
      expect(response).to redirect_to('/admin/link_tracking')
    end     
  end
end