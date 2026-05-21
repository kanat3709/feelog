# frozen_string_literal: true

class MypageController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = current_user.posts
                         .includes(:emotions, image_attachment: :blob)
                         .order(visited_at: :desc, created_at: :desc)

    # likesテーブルが存在する場合のみカウント（存在しなければ0）
    @total_likes = 0

    # 感情サマリ（emotions.id順で表示）
    @emotion_summary = Emotion.order(:id).each_with_object({}) do |emotion, hash|
      count = current_user.posts
                          .joins(post_emotions: :emotion)
                          .where(emotions: { id: emotion.id })
                          .count
      hash[emotion.name] = count if count.positive?
    end
  end
end
