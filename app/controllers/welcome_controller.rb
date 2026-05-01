# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    # マイページ実装後に有効化
    # redirect_to mypage_path if user_signed_in?
  end
end
