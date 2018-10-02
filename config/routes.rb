Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  root 'main#index'

  resources :lists

  get '/user/profile', to: 'users#view'
  get '/user/profile/edit', to: 'users#edit'
end
