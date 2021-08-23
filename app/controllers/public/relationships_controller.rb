class Public::RelationshipsController < ApplicationController

  # フォロー機能
  def create
    current_user.follow(params[:user_id])
    @user = User.find(params[:user_id])
    @user.create_notification_follow!(current_user)
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_id])
    @user = User.find(params[:user_id])
    redirect_to request.referer
  end
# フォロー・フォロワー一覧
  def follower
    user = User.find(params[:user_id])
    @users = user.following_user
  end

  def followed
    user = User.find(params[:user_id])
    @users = user.follower_user
  end

end
