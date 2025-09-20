# frozen_string_literal: true

Rails.application.routes.draw do
  root 'links#index'

  resources :links, only: %i[new create show]
  get '/:short_code', to: 'links#redirect', as: :redirect
  scope :api do
    scope :v1 do
      resources :links, only: [:create]
      post 'register', to: 'auth#register'
      post 'login', to: 'auth#login'
    end
  end
end
