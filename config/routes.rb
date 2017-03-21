Rails.application.routes.draw do
  #resources :courses
  #resources :subjects
  #resources :instructors
  get 'dataload/instructors'
  get 'dataload/subjects'
  get 'dataload/courses'
  get 'sessions/new'
  get 'sessions/destroy'
  get 'instructors/index'
  get 'subjects/index'
  get 'courses/index'
  get 'courses/search'
  post '/courses/search', to: 'courses#results'
  post 'courses/results', to: 'courses#enroll'

  resources :users
  get    '/login',   to: 'sessions#new', as: 'new_session_path'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  root 'application#home'
  get '*unmatched_route', to: 'application#not_found'
end
