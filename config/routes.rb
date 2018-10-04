Rails.application.routes.draw do
  devise_for :users, controllers: { 
    registrations: 'registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  root 'main#index'

  resources :lists
  resources :tasks

  #get '/lists/of/:id', to: 'lists#lists_of'

  get '/user/profile', to: 'users#view'
  get '/user/profile/edit', to: 'users#edit'
end
