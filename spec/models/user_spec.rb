# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    it 'name・email・passwordがあれば有効であること' do
      user = build(:test_user)
      expect(user).to be_valid
    end

    it 'nameがなければ無効であること' do
      user = build(:test_user, name: nil)
      expect(user).not_to be_valid
    end

    it 'emailがなければ無効であること' do
      user = build(:test_user, email: nil)
      expect(user).not_to be_valid
    end

    it 'emailが重複している場合は無効であること' do
      create(:test_user, email: 'dup@example.com')
      user = build(:test_user, email: 'dup@example.com')
      expect(user).not_to be_valid
    end

    it 'passwordが6文字未満であれば無効であること' do
      user = build(:test_user, password: 'abc12', password_confirmation: 'abc12')
      expect(user).not_to be_valid
    end
  end

  describe 'アソシエーション' do
    it '複数の投稿を持てること' do
      user = create(:test_user)
      create_list(:travel_post, 3, user: user)
      expect(user.posts.count).to eq(3)
    end
  end
end
