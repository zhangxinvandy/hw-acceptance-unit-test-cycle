Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  get 'same_director_movies/:id' => 'movies#search_director', as: :same_director_movie
end