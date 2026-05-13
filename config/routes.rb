Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'api/v1/auth/registrations'
  }
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  root to: 'api/v1/products#index'

  # Liveness/readiness endpoint for container probes.
  get 'up' => 'rails/health#show', as: :rails_health_check

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :customers do
        resources :orders, except: :update
      end
      resources :products, except: :show
    end
  end
end
