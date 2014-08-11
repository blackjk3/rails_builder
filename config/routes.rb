RailsBuilder::Engine.routes.draw do
  root :to => "builder#index"

  get 'migrations/migrate' => 'migrations#migrate', as: :migrate
  get 'migrations/rollback' => 'migrations#rollback', as: :rollback

  get 'migrations/up' => 'migrations#up', as: :up_migration
  get 'migrations/down' => 'migrations#down', as: :down_migration
  get 'migrations/reload' => 'migrations#reload', as: :reload_migration

  resources :routes, only: :index
  resources :statistics, only: :index
  resources :models, only: :index
  resources :controllers, only: :index
  resources :templates, only: :index
  resources :migrations, only: :index
end