# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_emotions, only: %i[new create edit update]  
  before_action :set_post, only: %i[show edit update destroy]             

  def show; end

  def new
    @post = Post.new
  end

  def edit; end  

  def create
    if params[:post][:image].present? && params[:post][:image].size > 10.megabytes
      @post = current_user.posts.build(post_params.except(:image))
      @post.errors.add(:image, 'のサイズは10MB以下にしてください')
      render :new, status: :unprocessable_content
      return
    end

    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to mypage_path, notice: '旅の記録を投稿しました！'
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if params[:post][:image].present? && params[:post][:image].size > 10.megabytes
      @post.errors.add(:image, 'のサイズは10MB以下にしてください')
      render :edit, status: :unprocessable_content
      return
    end

    # 削除フラグが立っていたら既存画像を削除
    if params[:post][:remove_image] == '1'
      @post.image.purge_later
    end

    if @post.update(post_params)  # ← post_paramsにremove_imageを含めない
      redirect_to mypage_path, notice: '旅の記録を更新しました！'
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @post.destroy
    redirect_to mypage_path, notice: '投稿を削除しました。'
  end

  private

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def set_emotions
    @emotions = Emotion.order(:id)
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