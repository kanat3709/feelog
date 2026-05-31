# frozen_string_literal: true

class MapController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = current_user.posts.where.not(latitude: nil, longitude: nil)
  end
end