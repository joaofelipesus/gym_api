Rails.application.routes.draw do
  get '/training_routines/progress', to: 'training_routines#progress'   #remove user_id from route
  get '/workout_reports/progress', to: 'workout_reports#progress'       #remove user_id from route
  get '/series_reports/:exercise_id/progression', to: 'series_reports#progression'
  get '/training_routines/can_be_complete', to: 'training_routines#can_be_complete'
  resources :exercise_reports
  resources :series_reports
  resources :workout_reports
  resources :workouts
  resources :training_routines
  resources :exercises
  devise_for :users
end
