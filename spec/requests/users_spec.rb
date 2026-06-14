# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'POST /users (新規登録)' do
    it '有効な情報で登録できること' do
      expect do
        post user_registration_path, params: {
          user: {
            name: 'テストユーザー',
            email: 'newuser@example.com',
            password: 'password123',
            password_confirmation: 'password123',
            terms_of_service: '1'
          }
        }
      end.to change(User, :count).by(1)
    end

    it 'メールアドレスが重複している場合は登録できないこと' do
      create(:test_user, email: 'existing@example.com')
      expect do
        post user_registration_path, params: {
          user: {
            name: '別のユーザー',
            email: 'existing@example.com',
            password: 'password123',
            password_confirmation: 'password123',
            terms_of_service: '1'
          }
        }
      end.not_to change(User, :count)
    end
  end

  describe 'POST /users/sign_in (ログイン)' do
    let(:user) { create(:test_user, email: 'login@example.com', password: 'password123') }

    it '正しい認証情報でログインできること' do
      post user_session_path, params: {
        user: { email: user.email, password: 'password123' }
      }
      expect(response).to have_http_status(:redirect)
    end

    it '誤ったパスワードではログインできないこと' do
      post user_session_path, params: {
        user: { email: user.email, password: 'wrongpassword' }
      }
      expect(response).to have_http_status(:unprocessable_content)
    end
  end

  describe 'DELETE /users/sign_out (ログアウト)' do
    it 'ログアウトできること' do
      user = create(:test_user)
      sign_in user
      delete destroy_user_session_path
      expect(response).to have_http_status(:redirect)
    end
  end
end
