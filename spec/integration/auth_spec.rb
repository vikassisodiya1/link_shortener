# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'API V1 Auth', type: :request do
  path '/api/v1/register' do
    post 'Register new user' do
      tags 'Auth'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string }
        },
        required: %w[email password password_confirmation]
      }

      response '201', 'user registered' do
        let(:user) { { email: 'new@example.com', password: 'password123', password_confirmation: 'password123' } }
        run_test!
      end
    end
  end

  path '/api/v1/login' do
    post 'Login user' do
      tags 'Auth'
      consumes 'application/json'
      parameter name: :credentials, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }

      response '200', 'user logged in' do
        let!(:user) do
          create(:user, email: 'login@example.com', password: 'password123', password_confirmation: 'password123')
        end
        let(:credentials) { { email: 'login@example.com', password: 'password123' } }
        run_test!
      end

      response '401', 'invalid credentials' do
        let(:credentials) { { email: 'login@example.com', password: 'wrong' } }
        run_test!
      end
    end
  end
end
