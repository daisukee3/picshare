Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'articles#index'
  
  resource :profile, only: [:show, :edit, :update]
  resources :articles do
    resources :comments, only: [:show, :new, :create]

    resource :like, only: [:create, :destroy]
  end
end
