# frozen_string_literal: true

Rails.application.routes.draw do
  root 'welcome#index'

  # 利用規約・プライバシーポリシー
  get 'terms',   to: 'static_pages#terms'
  get 'privacy', to: 'static_pages#privacy'

  devise_for :users

  # マイページ
  get 'mypage', to: 'mypage#index', as: :mypage

  # 投稿
  resources :posts do
    member do
      post   :like
      delete :unlike
      post   :wish
      delete :unwish
    end
  end

  # いいね一覧
  get 'likes',      to: 'likes#index',      as: :likes

  # マップ
  get 'map',        to: 'map#index',        as: :map

  # 行きたい！一覧
  get 'wish_lists', to: 'wish_lists#index', as: :wish_lists

  # ユーザー情報変更
  resources :users, only: [:edit, :update]

  # ヘルスチェック
  get 'up' => 'rails/health#show', as: :rails_health_check

  # PWA（必要になったらコメントアウトを外す）
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end