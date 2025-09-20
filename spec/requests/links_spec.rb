# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Links', type: :request do
  let(:user) { create(:user, email: 'client@example.com', password: 'password123') }
  let(:token) { JsonWebToken.encode(user_id: user.id) }
  let(:headers) do
    { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
  end

  describe 'POST /api/v1/links' do
    it 'creates a short URL with valid token' do
      post '/api/v1/links', params: { original_url: 'https://example.com' }.to_json,
                            headers: headers.merge({ 'Authorization' => "Bearer #{token}" })

      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)
      expect(response.code).to eq('201')
      expect(json['data']['short_url']).to include('http')
    end

    it 'returns unauthorized without token' do
      post '/api/v1/links', params: { original_url: 'https://example.com' }.to_json, headers: headers
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
