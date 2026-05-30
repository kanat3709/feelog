# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to mypage_path, notice: 'プロフィールを更新しました！'
    else
      render :edit, status: :unprocessable_content
    end
  end

  private

  def set_user
    # 他ユーザーのプロフィールは編集不可
    @user = current_user
  end

  def user_params
    params.expect(user: %i[name avatar])
  end
end
