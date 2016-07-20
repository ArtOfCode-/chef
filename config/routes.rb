Rails.application.routes.draw do
  devise_for :users

  root :to => 'home#index'

  get    'recipes/public',                     :to => 'recipes#public_list'
  get    'recipes/internal',                   :to => 'recipes#internal_list'
  get    'recipes/mine',                       :to => 'recipes#my_list'
  get    'recipes/new',                        :to => 'recipes#new'
  post   'recipes/new',                        :to => 'recipes#create'
  get    'recipes/:id',                        :to => 'recipes#show'
  delete 'recipes/:id',                        :to => 'recipes#destroy'
  get    'recipes/:id/edit',                   :to => 'recipes#edit'
  patch  'recipes/:id/edit',                   :to => 'recipes#update'

  post   'recipes/:id/favorite',               :to => 'favorites#toggle_favorite'

  post   'recipes/:id/comment',                :to => 'comments#create'
  delete 'comments/:id',                       :to => 'comments#destroy'

  get    'users',                              :to => 'users#index'
  get    'users/:id',                          :to => 'users#show'
  get    'users/:id/recipes/:type',            :to => 'users#recipes'

  match  '/403',                               :to => 'errors#forbidden',       :via => :all
  match  '/404',                               :to => 'errors#not_found',       :via => :all
  match  '/409',                               :to => 'errors#conflict',        :via => :all
  match  '/422',                               :to => 'errors#unprocessable',   :via => :all
  match  '/500',                               :to => 'errors#internal',        :via => :all
end
