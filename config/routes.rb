R12Team455::Application.routes.draw do
  get "pages/index"

  devise_for :users

  get "sessions/index"

  root :to => 'sessions#index'

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

  end

end
