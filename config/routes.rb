Rails.application.routes.draw do
# deviseのルーティング
  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }
  devise_for :user, controllers: {
    sessions:      'user/sessions',
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
end
