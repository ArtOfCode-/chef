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
end
