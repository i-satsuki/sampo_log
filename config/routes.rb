Rails.application.routes.draw do
  get '/search', to: 'search#search'
  get 'charts/monthly'
  get '/events', to: 'events#index'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :posts do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  resources :users, only: [:show, :edit, :update]do
      resource :relationships, only: [:create, :destroy]
  		# 退会機能
      member do
          get "unsubscribe"
          patch "withdraw"
          get "following"
          get "follower"
      end
  end



  devise_scope :user do
    root "devise/sessions#new"
  end
end
