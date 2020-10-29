Rails.application.routes.draw do
  root 'homes#index'
  get 'home/about'
  devise_for :users
  resources :books
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
