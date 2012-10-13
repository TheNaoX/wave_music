R12Team455::Application.routes.draw do
  devise_for :users

  get "sessions/index"

  root :to => 'sessions#index'

  namespace :api do
    resources :songs, only: [:index, :show]
    resources :playlists, only: [:index, :show]
  end

end
