Rails.application.routes.draw do
  namespace :admin do
    resources :databases
  end
end
