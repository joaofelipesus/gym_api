Rails.application.routes.draw do
  get '/training_routines/:user_id/progress', to: 'training_routines#progress'
  resources :training_routines
  resources :exercises
  devise_for :users
end
