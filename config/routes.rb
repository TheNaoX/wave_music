R12Team455::Application.routes.draw do
  devise_for :users

  get "sessions/index"

  root :to => 'sessions#index'

  namespace :api do
    resources :songs, only: [:index, :show] do
      member do
        get :stream
      end
    end
    resources :playlists, only: [:index, :show, :create] do
      member do
        put :add_songs
      end
    end
    resources :uploads, only: [:create]
  end

end
