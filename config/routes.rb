Rails.application.routes.draw do
  get 'hospitals/index'
  get 'hospitals/show'
  post 'pages/home'

  get '/tagged', to: "hospitals#tagged", as: :tagged
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :hospitals, only: [:index, :show, :new, :create] do
    resources :comments, only: [:show, :new, :create]
  end
  get '/users/dashboard', to: 'pages#dashboard'
  get '/users/profile', to: 'users#show'
end
