Rails.application.routes.draw do
  # ルートパス(未ログイン時トップ画面)
  root to: "users/homes#top"

  # gem devise 管理者
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations',
  }

  # gem devise 利用者
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
  }
  # ゲストユーザーログイン
  post '/homes/guest_sign_in', to: 'users/homes#new_guest'

  # 使い方ページの表示
  get '/how_to' => 'users/homes#how_to'

  # 利用者退会画面の表示
  get '/mypages/unsubscribe' => 'users/mypages#unsubscribe'

  # 利用者の退会処理(有効フラグカラムを退会済に変える)
  patch '/mypages/withdraw' => 'users/mypages#withdraw'

  # タスクを開始したときの処理(タスクテーブルにデータが作成される)
  patch '/lists/start' => 'users/lists#start'

  # メモを全て削除する処理
  delete '/memo/destroy_all/:id' => 'users/memos#destroy_all', as: 'destroy_all'

  # ルームを検索する処理
  get '/searchs/room' => 'users/rooms#search', as: 'search_room'

  # URLにadminsを含ませる
  namespace :admins do
    resources :contacts, only: [:index, :show, :update]
    resources :rooms, only: [:index, :update]
    resources :users, only: [:index, :update]
    resources :analysis, only: [:index]
  end

  # URLにusersを含ませない
  scope module: :users do
    resources :rooms, except: [:index, :edit, :destroy]
    resources :contacts, only: [:new, :create]
    resources :mains, only: [:show, :update]
    resources :lists, only: [:create, :update, :destroy]
    resources :memos, only: [:create, :destroy]
    resources :analysis, only: [:show, :edit]
    # URLにidをもたせないため単数形
    resource :mypages, only: [:edit, :update]
  end
end
