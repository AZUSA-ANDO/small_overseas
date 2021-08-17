class Public::RelationshipsController < ApplicationController

  # ——————フォロー機能を作成・保存・削除する————————————
  def create
    current_user.follow(params[:user_id])
    @user = User.find(params[:user_id])
    # redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_id])
    @user = User.find(params[:user_id])
    # redirect_to request.referer
  end
#————————フォロー・フォロワー一覧を表示する-————————————
  def follower
    user = User.find(params[:user_id])
    @users = user.following_user
  end

  def followed
    user = User.find(params[:user_id])
    @users = user.follower_user
  end

end
