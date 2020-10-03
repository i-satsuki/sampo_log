Rails.application.routes.draw do
  get 'search/search'
  get 'charts/weekly'
  get 'events/index'
  post 'follow/:id', to: 'relationships#follow', as: 'follow'
  post 'unfollow/:id', to: 'relationships#unfollow', as: 'unfollow'
  get 'users/following/:user_id', to: 'users#following', as:'users_following'
  get 'users/follower/:user_id', to: 'users#follower', as:'users_follower'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :posts
  resources :users, only: [:show, :edit, :update]do
  		# 退会機能
      member do
          get "unsubscribe"
          patch "withdrawl"
      end
  end

  devise_scope :user do
    root "devise/sessions#new"
  end
end
