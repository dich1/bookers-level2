Rails.application.routes.draw do
  get 'books/index'
  get 'books/show'
  get 'books/create'
  get 'books/edit'
  get 'books/update'
  get 'books/destroy'
  get 'home/index'
  get 'home/about'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
