Rails.application.routes.draw do
  devise_for :users, controllers: { 
    registrations: 'registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # CSV
  get 'lists/csv', to: 'lists#csv'

  root 'main#index'

  resources :lists
  resources :tasks

  get '/export/csv/lists', to: 'lists#export_csv'
  get '/export/csv/tasks', to: 'tasks#export_csv'
  get '/export/csv/tasks/:id', to: 'tasks#export_csv_from_list'

  get '/user/profile', to: 'users#view'
  get '/user/profile/edit', to: 'users#edit'
end
