Rails.application.routes.draw do
  namespace :admin do
    get '/databases/list/:status', to: 'databases#list'
    get '/databases/tables', to: 'databases#tables'
    get '/databases/tables/:status', to: 'databases#tables'
    resources :databases
  end
end
