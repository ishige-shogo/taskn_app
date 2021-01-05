Rails.application.routes.draw do
  namespace :admins do
    get 'analysis/index'
  end
  namespace :admins do
    get 'users/index'
    get 'users/update'
  end
  namespace :admins do
    get 'logs/index'
  end
  namespace :admins do
    get 'rooms/index'
    get 'rooms/update'
  end
  namespace :admins do
    get 'contacts/index'
    get 'contacts/show'
    get 'contacts/update'
  end
  devise_for :admins
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
