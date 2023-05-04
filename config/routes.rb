Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "homes#top"
  get "/home/about" => "homes#about" ,as: "about"
  get "/relationships/follow"
  get "/relationships/follower"

  devise_for :users
  resources :users, only: [:show, :edit, :update, :index]
  resources :books, only: [:index, :show, :edit, :create, :destroy, :update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users do
    resources :relationships, only: [:create, :destroy]
  end
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
