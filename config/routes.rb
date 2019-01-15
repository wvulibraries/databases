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
    # subjects
    resources :subjects
    get '/curated', to: 'subjects#curated', as: 'curated'
    get '/curated/:subject/sort', to: 'subjects#sort', as: 'sort_curated'
    post '/curated', to: 'subjects#update_curated', as: 'update_curated'
  end
end
