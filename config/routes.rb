Rails.application.routes.draw do
  # FRONTEND
  # ------------------------------------------------------------------
  root to: 'public/base#index'
  get '/', to: 'public/base#index'

  # Search
  get '/search(/:page)', to: 'public/search#index'

  # Feedback
  get '/feedback(/:db_id)', to: 'public/feedback#index'
  post '/feedback', to: 'public/feedback#email_submission'

  # Reporting
  get '/report(/:db_id)', to: 'public/report#index'
  post '/report', to: 'public/report#error_report'

  # A to Z Listings
  get '/AtoZ', to: 'public/base#all'
  get '/AtoZ/:character', to: 'public/base#a_to_z'

  # Subject Listings
  get '/subject', to: 'public/base#subject'
  get '/subjects', to: 'public/base#subject'
  get '/databases/subjects', to: redirect('/subjects')
  get '/subject/:id', to: 'public/base#subject_databases'

  # landing pages
  get '/about/:uuid', to: 'public/about#index'

  # url connection
  get '/connect/:uuid', to: 'public/connect#index'

  # CAS
  # ------------------------------------------------------------------
  get '/login',
      to: 'application#login',
      as: 'login'

  get '/signout',
      to: 'application#signout',
      as: 'signout'

  get '/logout',
      to: 'application#logout',
      as: 'logout'

  # ADMIN
  # ------------------------------------------------------------------
  get '/admin', to: 'admin#home', as: 'admin'

  namespace :admin do
    # databases
    get '/databases/list', to: 'databases#listall'
    get '/databases/list/:status', to: 'databases#list'
    get '/databases/tables', to: 'databases#tables'
    get '/databases/tables/:status', to: 'databases#tables'
    get '/databases/libguides', to: 'databases#lib_guides'
    resources :databases

    # import databases
    get '/import', to: 'databases#import'
    post '/import', to: 'databases#csv_import'

    # vendors
    resources :vendors

    # resources
    resources :resources

    # subjects
    resources :subjects
    get '/curated', to: 'subjects#curated', as: 'curated'
    get '/curated/:subject/sort', to: 'subjects#sort', as: 'sort_curated'
    post '/curated', to: 'subjects#update_curated', as: 'update_curated'

    # landing pages
    resources :landing_pages

    # users
    resources :users

    # link tracking
    resources :link_tracking    
  end
end
