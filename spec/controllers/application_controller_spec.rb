require 'rails_helper'

describe ApplicationController, type: :controller do
  describe '.client_ip' do
    it 'to return the ip of the client' do
      expect(controller.client_ip).to eq(request.remote_ip)
    end
  end 
end