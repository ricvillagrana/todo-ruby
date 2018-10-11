Rails.application.routes.draw do
  devise_for :users, controllers: { 
    registrations: 'registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  get '/send_mail', to: 'main#send_mail'
  get '/schedule_mail', to: 'main#schedule_mail'

  root 'main#index'

  resources :lists
  resources :tasks

  get '/export/lists', to: 'lists#export'
  get '/export/tasks', to: 'tasks#export'
  get '/export/tasks/:id', to: 'tasks#export_from_list'

  get '/user/profile', to: 'users#view'
  get '/user/profile/edit', to: 'users#edit'
end
