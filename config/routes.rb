Rails.application.routes.draw do
  resources :movie_requests, only: [:new, :create, :show]
  get '/movie_requests', to: redirect('movie_requests/new')
  get '/', to: redirect('movie_requests/new')
end
