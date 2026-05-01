# frozen_string_literal: true

class MypageController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = current_user.posts
                         .includes(:emotions, image_attachment: :blob)
                         .order(visited_at: :desc, created_at: :desc)

    # likesテーブルが存在する場合のみカウント（存在しなければ0）
    @total_likes = 0

    # 感情サマリ
    @emotion_summary = current_user.posts
                                   .joins(post_emotions: :emotion)
                                   .group('emotions.name')
                                   .count
  end
end
