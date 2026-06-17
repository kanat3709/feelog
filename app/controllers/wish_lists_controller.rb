# frozen_string_literal: true

class WishListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_wish_list, only: %i[destroy toggle_visited]

  def index
    @wish_lists = current_user.wish_lists.includes(:post).order(created_at: :desc)
  end

  def create
    post = Post.find(params[:post_id])
    current_user.wish_lists.create!(post:)
    @post = post
    @wish_list = current_user.wish_lists.find_by(post:)
  end

  def destroy
    @post = @wish_list.post
    @wish_list.destroy!
  end

  def toggle_visited
    @wish_list.update!(visited: !@wish_list.visited)
    @post = @wish_list.post
  end

  private

  def set_wish_list
    @wish_list = current_user.wish_lists.find(params[:id])
  end
end
