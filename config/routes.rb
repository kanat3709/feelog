# frozen_string_literal: true

Rails.application.routes.draw do
  root 'welcome#index'

  # 利用規約・プライバシーポリシー
  get 'terms',   to: 'static_pages#terms'
  get 'privacy', to: 'static_pages#privacy'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # 公開投稿
  get 'public_posts',     to: 'public_posts#index', as: :public_posts
  get 'public_posts/:id', to: 'public_posts#show',  as: :public_post

  # マイページ
  get 'mypage', to: 'mypage#index', as: :mypage

  # 投稿
  resources :posts do
    member do
      post   :wish
      delete :unwish
      post   :hide
      post   :unhide
    end
  end

  # いいね
  resources :likes, only: %i[create destroy], param: :post_id

  # いいね一覧
  get 'likes', to: 'likes#index', as: :likes_index

  # マップ
  get 'map',        to: 'map#index',        as: :map

  # 行きたい！一覧
  get 'wish_lists', to: 'wish_lists#index', as: :wish_lists

  # ユーザー情報変更
  resources :users, only: %i[edit update]

  # ヘルスチェック
  get 'up' => 'rails/health#show', as: :rails_health_check

  # PWA（必要になったらコメントアウトを外す）
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
