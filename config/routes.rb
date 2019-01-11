Rails.application.routes.draw do
  post '/refresh', to: 'dashboard#refresh'

  get 'auth/:provider/callback', to: 'sessions#googleAuth'
  get 'auth/failure', to: redirect('/')

  # route to get systems by department
  get 'get_systems_by_dept/:department_id', to: 'eu_exit_dash#get_systems_by_dept'  

  # run create links function
  get '/create/links', to: 'system_link#generate_links'
  
  resources :protocols
  get 'dashboard/index', as: 'home'
  resources :agencies
  resources :programs
  resources :services
  resources :system_links
  resources :system_departments
  resources :systems
  resources :departments
  resources :eu_exit_dash
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'dashboard#index'
end
