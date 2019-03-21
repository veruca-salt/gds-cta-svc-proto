Rails.application.routes.draw do
  post '/refresh', to: 'dashboard#refresh'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'login/new', as: 'login'

  # get systems by department
  get 'get_systems_by_dept/:department_id', to: 'eu_exit_dash#get_systems_by_dept' 

  # get impacted systems
  get 'impact/:system_id', to: 'eu_exit_dash#impact'    

  # run create links function
  get '/create/links', to: 'system_link#generate_links'
  
  resources :sessions, only: [:create, :destroy]
  resources :protocols
  resources :agencies do
    collection do
        get 'add/:agency_name', to: 'agencies#add'
    end
  end
  resources :programs do
    collection do
        get 'add/:program_name', to: 'programs#add'
    end
  end
  resources :services
  resources :system_links
  resources :system_departments
  resources :systems
  resources :departments
  resources :eu_exit_dash
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'dashboard#index'
end
