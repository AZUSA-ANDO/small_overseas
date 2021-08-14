Rails.application.routes.draw do
# deviseのルーティング
  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }

# 管理者側のルーティング

  namespace :admin do

    resources :users, only: [:index, :show, :edit, :update]
    resources :overseas_areas, only: [:index, :edit, :update, :create, :destroy]

  end


  devise_for :user, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'log_in', to: 'users/sessions#new'
    post 'log_in', to: 'users/sessions#create'
    delete 'sign_out', to: 'users/sessions#destroy'
    get 'sign_up', to: 'users/registrations#new'
    post 'sign_up', to: 'users/registrations#create'
    delete 'sign_out', to: 'users/sessions#destroy'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

# 会員側のルーティング
   scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'

  resources :spots do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  resources :users, only: [:show, :edit, :update] do
    collection do
        get 'quit_check'
        patch 'quit'
    end
    resource :relationships, only: [:create, :destroy]
    get 'follows' => 'relationships#follower', as: 'follows'
    get 'followers' => 'relationships#followed', as: 'followers'
  end

    resources :messages, only: [:create,:destroy]
    resources :rooms, only: [:create,:show]

    get "area_search", to: "search#search", as: "search"

    get "rank_search", to: "spots#rank", as: "rank_search"


  end

end
