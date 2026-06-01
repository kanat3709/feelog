# frozen_string_literal: true

class MapController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = current_user.posts.where('latitude IS NOT NULL AND longitude IS NOT NULL')
  end
end
