Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'api/v1/auth/registrations'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  root to: 'api/v1/products#index'

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :customers do
        resources :orders, except: :update
      end
      resources :products, except: :show
    end
  end
end
