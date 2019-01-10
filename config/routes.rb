Rails.application.routes.draw do
  namespace :admin do
    # databases
    get '/databases/list/:status', to: 'databases#list'
    get '/databases/tables', to: 'databases#tables'
    get '/databases/tables/:status', to: 'databases#tables'
    resources :databases

    # vendors
    resources :vendors
    # resources
    resources :resources 
  end
end
