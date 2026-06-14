# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:user) { create(:test_user) }

  describe 'GET /public_posts (公開投稿一覧)' do
    it 'ログイン済みで正常にレスポンスが返ること' do
      sign_in user
      get public_posts_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /public_posts/:id (公開投稿詳細)' do
    it 'ログイン済みで正常にレスポンスが返ること' do
      sign_in user
      post_record = create(:travel_post, user: user, is_public: true)
      get public_post_path(post_record)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /posts/new (投稿作成フォーム)' do
    context 'ログイン済みの場合' do
      it '正常にレスポンスが返ること' do
        sign_in user
        get new_post_path
        expect(response).to have_http_status(:success)
      end
    end

    context '未ログインの場合' do
      it 'ログインページへリダイレクトされること' do
        get new_post_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST /posts (投稿作成)' do
    context 'ログイン済みの場合' do
      it '有効なパラメータで投稿が作成されること' do
        sign_in user
        expect do
          post posts_path, params: {
            post: {
              title: 'テスト旅行',
              memo: '楽しかった',
              place: '東京',
              visited_at: Time.zone.today,
              is_public: true
            }
          }
        end.to change(Post, :count).by(1)
      end

      it '無効なパラメータでは投稿が作成されないこと' do
        sign_in user
        expect do
          post posts_path, params: { post: { title: nil } }
        end.not_to change(Post, :count)
      end
    end
  end

  describe 'PATCH /posts/:id (投稿更新)' do
    context '投稿の所有者の場合' do
      it '正常に更新できること' do
        sign_in user
        post_record = create(:travel_post, user: user)
        patch post_path(post_record), params: { post: { title: '更新後タイトル' } }
        expect(post_record.reload.title).to eq('更新後タイトル')
      end
    end
  end

  describe 'DELETE /posts/:id (投稿削除)' do
    context '投稿の所有者の場合' do
      it '投稿が削除されること' do
        sign_in user
        post_record = create(:travel_post, user: user)
        expect do
          delete post_path(post_record)
        end.to change(Post, :count).by(-1)
      end
    end
  end
end
