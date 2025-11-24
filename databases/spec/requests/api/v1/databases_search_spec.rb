# frozen_string_literal: true
require 'rails_helper'


RSpec.describe 'Databases API: GET /api/v1/databases/search', type: :request do
  let(:api_key) { 'db-test-key' }

  # Simple AR-ish record for mapping
  Record = Struct.new(:id, :name, :vendor_name, :url_uuid, :description)

  def bearer_headers(key = api_key)
    { 'Authorization' => "Bearer #{key}", 'Accept' => 'application/json' }
  end

  def x_api_key_headers(key = api_key)
    { 'X-Api-Key' => key, 'Accept' => 'application/json' }
  end

  # Build a chainable ES scope double that responds to .per and .records
  def es_scope_with(records)
    scope = double('es_scope', records: records)
    allow(scope).to receive(:per) { |_n| scope }
    scope
  end

  before do
    # Ensure the controller sees the API key in ENV
    allow(ENV).to receive(:[]).and_call_original
    allow(ENV).to receive(:[]).with('DATABASES_API_KEY').and_return(api_key)
  end

  describe 'authentication' do
    it '503s when server key is not configured' do
      allow(ENV).to receive(:[]).with('DATABASES_API_KEY').and_return(nil)
      get '/api/v1/databases/search', params: { query: 'bio' }, headers: { 'Accept' => 'application/json' }
      expect(response).to have_http_status(:service_unavailable)
      expect(JSON.parse(response.body).dig('errors', 0, 'code')).to eq('service_unavailable')
    end

    it 'accepts Authorization: Bearer <key>' do
      allow(Database).to receive(:search).and_return(es_scope_with([]))
      get '/api/v1/databases/search', params: { query: 'bio' }, headers: bearer_headers
      expect(response).to have_http_status(:ok)
    end

    it 'accepts X-Api-Key header' do
      allow(Database).to receive(:search).and_return(es_scope_with([]))
      get '/api/v1/databases/search', params: { query: 'bio' }, headers: x_api_key_headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'validation & pagination' do
    it '400s when query is missing' do
      get '/api/v1/databases/search', headers: bearer_headers
      expect(response).to have_http_status(:bad_request)
      body = JSON.parse(response.body)
      expect(body.dig('errors', 0, 'code')).to eq('missing_parameter').or eq('missing_query')
    end

    it 'defaults per_page to 3 when not provided or <= 0' do
      recs = [
        Record.new(1, 'BioBase', 'Acme', 'u1', 'db 1'),
        Record.new(2, 'ChemBase', 'Acme', 'u2', 'db 2')
      ]
      allow(Database).to receive(:search).and_return(es_scope_with(recs))

      get '/api/v1/databases/search', params: { query: 'bio', per_page: 0 }, headers: bearer_headers
      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body['per_page']).to eq(3)
    end

    it 'caps per_page at 10' do
      recs = (1..12).map { |i| Record.new(i, "DB #{i}", 'V', "uuid#{i}", 'desc') }
      scope = es_scope_with(recs)
      # Ensure .per(n) is called with clamped 10 (optional strictness)
      expect(scope).to receive(:per).with(10).and_return(scope)
      allow(Database).to receive(:search).and_return(scope)

      get '/api/v1/databases/search', params: { query: 'bio', per_page: 999 }, headers: bearer_headers
      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body['per_page']).to eq(10)
    end
  end

  describe 'success response' do
    it 'returns normalized result items' do
      recs = [
        Record.new(1, 'BioBase', 'Acme', 'abc123', 'Great for biology'),
        Record.new(2, 'GeoBase', 'Globex', 'def456', 'Great for geology')
      ]
      allow(Database).to receive(:search).and_return(es_scope_with(recs))

      get '/api/v1/databases/search', params: { query: 'bio', per_page: 5 }, headers: bearer_headers
      expect(response).to have_http_status(:ok)

      body = JSON.parse(response.body)
      expect(body['query']).to eq('bio')
      expect(body['count']).to eq(2)
      expect(body['results'].first.keys).to include('id', 'title', 'vendor', 'url', 'snippet')
      expect(body['results'].first['url']).to match(%r{https?://.+/connect/abc123})
    end

    it 'sets Cache-Control and ETag; returns 304 on revalidation' do
      recs = [Record.new(1, 'BioBase', 'Acme', 'abc123', 'desc')]
      allow(Database).to receive(:search).and_return(es_scope_with(recs))

      get '/api/v1/databases/search', params: { query: 'bio', per_page: 3 }, headers: bearer_headers
      expect(response).to have_http_status(:ok)
      expect(response.headers['Cache-Control']).to include('max-age=30')
      etag = response.headers['ETag']
      expect(etag).to be_present

      # Second request with If-None-Match should 304 if nothing changed
      allow(Database).to receive(:search).and_return(es_scope_with(recs))
      get '/api/v1/databases/search',
          params: { query: 'bio', per_page: 3 },
          headers: bearer_headers.merge('If-None-Match' => etag)

      expect(response).to have_http_status(:not_modified)
      expect(response.body).to be_blank
    end
  end

  
end
