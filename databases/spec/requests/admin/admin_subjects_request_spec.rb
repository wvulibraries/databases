require "rails_helper"

RSpec.describe "Subjects", :type => :request do
  let(:subject) { FactoryBot.create(:subject) }
  let(:attrs) { FactoryBot.attributes_for(:subject) }
  let(:database) { FactoryBot.create(:database_basic) }

  context '#show' do
    it "routes to #show" do
      get "/admin/subjects/1" 
      expect(response).to redirect_to("/admin/subjects")
    end
  end   

  context 'forcing bad results that feature tests would not cover' do
    it "#sort" do
      post "/admin/curated", :params => { :curated => { :id => ['32', '2', '3'], :sort => ['Default', 'Low', 'Default'] }}
  
      expect(response).to redirect_to('/admin/subjects')
      follow_redirect!
  
      expect(response.body).to include("Either sort enumeration is not correct or the ID can not be found.")
    end
  end 
end