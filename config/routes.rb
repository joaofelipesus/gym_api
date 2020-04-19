Rails.application.routes.draw do
  resources :training_routines
  resources :exercises
  devise_for :users
end
