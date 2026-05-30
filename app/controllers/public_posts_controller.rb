# frozen_string_literal: true

class PublicPostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.where(is_public: true)
                 .includes(:user)
                 .order(created_at: :desc)
  end
end
