Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "homes#top"
  get "/home/about" => "homes#about" ,as: "about"
  devise_for :users
  resources :users, only: [:show, :edit, :update, :index]
  resources :books, only: [:index, :show, :edit, :create, :destroy, :update] do
    resource :favorites, only: [:create, :destroy]
  end
  resources :books, only: [:new, :create, :index, :show, :destroy] do
    resources :book_comments, only: [:create]
  end


    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
