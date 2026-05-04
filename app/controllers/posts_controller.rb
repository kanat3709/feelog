# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_emotions, only: %i[new create]
  before_action :set_post, only: [:show]

  def show; end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to mypage_path, notice: '旅の記録を投稿しました！'
    else
      render :new, status: :unprocessable_content
    end
  end

  private

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def set_emotions
    @emotions = Emotion.all
  end

  # rubocop:disable Rails/StrongParametersExpect
  def post_params
    params.require(:post).permit(
      :title,
      :memo,
      :place,
      :visited_at,
      :is_public,
      :image,
      emotion_ids: []
    )
  end
  # rubocop:enable Rails/StrongParametersExpect
end
