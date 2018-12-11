Rails.application.routes.draw do
  namespace :admin do
    resources :databases
    get '/databases/list/:status', to: 'databases#list'
    get '/databases/:status', to: 'databases#index'
  end
end
