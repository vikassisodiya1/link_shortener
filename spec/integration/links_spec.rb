# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'API V1 Links', type: :request do
  path '/api/v1/links' do
    post 'Create Short URL' do
      tags 'Links'
      consumes 'application/json'
      produces 'application/json'
      security [{ Bearer: [] }]
      parameter name: :link, in: :body, schema: {
        type: :object,
        properties: {
          link: { type: :object, properties: { original_url: { type: :string } },
                  required: ['original_url'] }
        }
      }

      response '201', 'URL created' do
        let(:user) do
          create(:user, email: 'client@example.com', password: 'password123', password_confirmation: 'password123')
        end
        let(:Authorization) { "Bearer #{JsonWebToken.encode(user_id: user.id)}" }
        let(:link) { { link: { original_url: 'https://example.com' } } }

        run_test! do |response|
          data = JSON.parse(response.body)['data']
          expect(data['short_url']).to be_present
        end
      end

      response '401', 'Unauthorized' do
        let(:Authorization) { nil }
        let(:link) { { link: { original_url: 'https://example.com' } } }
        run_test!
      end
    end
  end
end
