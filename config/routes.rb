Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "homes#top"

  resources :post_images, only: [:new, :create, :index, :edit, :update, :show, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy, :show]
  end

  resources :users, only: [:show, :edit, :update, :destroy]
  resources :item_images, only: [:new, :create, :index, :show, :edit, :update, :destroy]

  get '/withdraw', to: 'users#withdraw', as: 'withdraw'

end
