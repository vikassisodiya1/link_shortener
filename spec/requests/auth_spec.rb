# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Auths', type: :request do
  describe 'POST /api/v1/register' do
    it 'registers a new user and returns token' do
      post '/api/v1/register', params: { email: 'new@example.com', password: 'password123' }
      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)
      expect(json['token']).to be_present
    end
  end
  describe 'POST /api/v1/login' do
    let!(:user) { create(:user, email: 'login@example.com', password: 'password123') }

    it 'returns token with valid credentials' do
      post '/api/v1/login', params: { email: 'login@example.com', password: 'password123' }
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['token']).to be_present
    end

    it 'returns unauthorized with invalid credentials' do
      post '/api/v1/login', params: { email: 'login@example.com', password: 'wrongpass' }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
