Rails.application.routes.draw do
  namespace :users do
    get 'analysis/index'
    get 'analysis/show'
  end
  namespace :users do
    get 'memos/create'
    get 'memos/destroy'
    get 'memos/destroy_all'
  end
  namespace :users do
    get 'lists/new'
    get 'lists/create'
    get 'lists/destroy'
    get 'lists/update'
    get 'lists/start'
  end
  namespace :users do
    get 'mains/index'
    get 'mains/edit'
    get 'mains/update'
    get 'mains/exit'
  end
  namespace :users do
    get 'contacts/index'
    get 'contacts/new'
    get 'contacts/create'
  end
  namespace :users do
    get 'mypages/edit'
    get 'mypages/update'
    get 'mypages/unsubscribe'
    get 'mypages/withdraw'
  end
  namespace :users do
    get 'rooms/index'
    get 'rooms/show'
    get 'rooms/update'
    get 'rooms/new'
    get 'rooms/create'
  end
  namespace :users do
    get 'homes/top'
    get 'homes/how_to'
  end
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
