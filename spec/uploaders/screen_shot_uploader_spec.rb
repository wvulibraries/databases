require 'rails_helper'
require 'carrierwave/test/matchers'

describe ScreenShotUploader do
  include CarrierWave::Test::Matchers

  let(:report) { double('report') }
  let(:uploader) { ScreenShotUploader.new(report, :screenshot) }

  before do
    ScreenShotUploader.enable_processing = true
    File.open("#{Rails.root}/spec/support/files/test_1.jpg") { |f| uploader.store!(f) }
  end

  after do
    ScreenShotUploader.enable_processing = false
    uploader.remove!
  end

  context 'coverage report' do
    it 'checks cache folder' do
      tmp_path = "#{Rails.root}/public/uploads/test/tmp/"
      expect(uploader.cache_dir).to eq(tmp_path)
    end

    it 'checks upload folder' do
      up_path = "#{Rails.root}/public/uploads/test/r_spec/mocks/double/"
      expect(uploader.store_dir).to eq(up_path)
    end
    
    it 'checks whitelist types' do
      files =  %w[jpg jpeg gif png]
      expect(uploader.extension_allowlist).to eq(files)
    end
  end

end
