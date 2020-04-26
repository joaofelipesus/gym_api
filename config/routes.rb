Rails.application.routes.draw do
  get '/training_routines/:user_id/progress', to: 'training_routines#progress'
  get '/workout_reports/:user_id/progress', to: 'workout_reports#progress'
  resources :workout_reports
  resources :workouts
  resources :training_routines
  resources :exercises
  devise_for :users
end
