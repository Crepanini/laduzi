Rails.application.routes.draw do
  get 'hospitals/index'
  get 'hospitals/show'
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :hospitals, only: [:index, :show, :new, :create] do
    resources :comments, only: [:show, :new, :create]
  end

end
