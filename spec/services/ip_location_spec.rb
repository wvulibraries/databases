require 'rails_helper'

describe IpLocation, type: :model do

  context '.campus?' do
    on_campus_ip = ["157.182.0.0", "157.182.0.1", "157.182.0.2", "157.182.0.3", "157.182.0.4", "157.182.0.5", "157.182.0.6", "157.182.0.7", "157.182.0.8", "157.182.0.9", "157.182.0.10", "157.182.0.11", "157.182.0.12", "157.182.0.13", "157.182.0.14", "157.182.0.15", "157.182.0.16"]

    on_campus_ip.each do |ip| 
      it 'should return true these are in the range of ip address alotted' do
        response = IpLocation.new(ip).campus?
        expect(response).to be true
      end
    end 

    it 'should return false on a non-campus ip' do
      ip = '22.3.43.45'
      response = IpLocation.new(ip).campus?
      expect(response).to be false
    end
  end

  context '.off_campus?' do
    off_campus_ip = [ 
      Faker::Internet.public_ip_v4_address, 
      Faker::Internet.private_ip_v4_address, 
      Faker::Internet.ip_v4_cidr, 
      Faker::Internet.ip_v6_address, 
      Faker::Internet.ip_v6_cidr
    ]

    off_campus_ip.each do |ip| 
      it "should be true because it is a valid off campus ip" do
        expect(described_class.new(ip).off_campus? ).to be true
      end
    end

    it 'should be false because on campuse ip' do 
      expect(described_class.new("157.182.0.1").off_campus? ).to be false
    end 
  end

end
