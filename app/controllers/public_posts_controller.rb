# frozen_string_literal: true

class PublicPostsController < ApplicationController
  before_action :authenticate_user!, only: []
  before_action :set_post, only: [:show]

  def index
    @query = params[:q].to_s.strip
    @posts = Post.where(is_public: true, hidden: false)
                 .includes(:user)
                 .order(created_at: :desc)

    # キーワード検索
    return if @query.blank?

    keyword = "%#{Post.sanitize_sql_like(@query)}%"
    @posts = @posts.where('title LIKE :kw OR place LIKE :kw', kw: keyword)
  end

  def show; end

  private

  def set_post
    @post = Post.find(params[:id])
    raise ActiveRecord::RecordNotFound unless @post.is_public?
    raise ActiveRecord::RecordNotFound if @post.hidden? && !current_user&.admin?
  end
end
