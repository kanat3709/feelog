# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'バリデーション' do
    it 'titleとuserがあれば有効であること' do
      post = build(:travel_post)
      expect(post).to be_valid
    end

    it 'titleがなければ無効であること' do
      post = build(:travel_post, title: nil)
      expect(post).not_to be_valid
    end
  end

  describe 'アソシエーション' do
    it 'userに属していること' do
      post = build(:travel_post)
      expect(post.user).to be_present
    end

    it 'userが削除されると投稿も削除されること' do
      user = create(:test_user)
      create(:travel_post, user: user)
    end
  end
end
