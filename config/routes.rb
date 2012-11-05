R12Team455::Application.routes.draw do
  root :to => 'pages#index'

  devise_for :api_users
  devise_for :users

  resources :pages, only: [:index]

  resources :uploads, only: [:index]


  namespace :api do

    resources :songs, only: [:index, :show] do

      collection do
        get :search
      end

      member do
        get :stream
      end
    end

    resources :playlists, only: [:index, :show, :create] do

      collection do
        get :search
      end

      member do
        post :add_songs
      end

    end

    resources :uploads, only: [:create]

    resources :sessions, only: [:create, :destroy]

  end

end
