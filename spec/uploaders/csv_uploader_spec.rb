require 'rails_helper'
require 'carrierwave/test/matchers'

describe CsvUploader do
  include CarrierWave::Test::Matchers

  let(:import_database) { double('import_database') }
  let(:uploader) { CsvUploader.new(import_database, :screenshot) }

  before do
    CsvUploader.enable_processing = true
    File.open("#{Rails.root}/spec/support/files/databases-test-import.csv") { |f| uploader.store!(f) }
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
      expect(uploader.extension_allowlist).to eq(%w[csv])
    end
  end

end
