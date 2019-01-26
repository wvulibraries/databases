Rails.application.routes.draw do
  get '/', to: 'public/base#index'
  get '/AtoZ', to: 'public/base#all'
  get '/AtoZ/:character', to: 'public/base#a_to_z'
  get '/subject', to: 'public/base#subject'
  get '/subject/:id', to: 'public/base#subject_databases'


  namespace :admin do
    # databases
    get '/databases/list', to: 'databases#listall'
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
