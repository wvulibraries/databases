require 'rails_helper'

describe Public::BaseController, type: :controller do
  describe '.client_ip' do
    it 'to return the ip of the client' do
      expect(controller.client_ip).to eq(request.remote_ip)
    end

    it 'expects it to set it as a global variable' do
      get :index
      expect(assigns(:client_ip)).to be_a(IPAddr)
    end 
  end 
end