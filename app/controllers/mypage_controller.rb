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
    @emotion_summary = build_emotion_summary
  end

  private

  def build_emotion_summary
    emotion_order = Emotion.order(:id).pluck(:name)
    emotion_counts = current_user.posts
                                 .joins(post_emotions: :emotion)
                                 .group('emotions.name')
                                 .count
    emotion_counts
      .select { |_name, count| count.positive? }
      .sort_by { |name, _count| emotion_order.index(name) || 999 }
      .to_h
  end
end
