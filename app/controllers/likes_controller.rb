# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!

  def index
    @liked_posts = current_user.likes.includes(:post).map(&:post)
  end

  def create
    @post = Post.find(params[:post_id])
    @post.likes.create!(user: current_user)
  end

  def destroy
    @post = Post.find(params[:post_id])
    like = @post.likes.find_by!(user: current_user)
    like.destroy!
  end
end
