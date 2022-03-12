class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  # フォローを作成
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end

  # フォローを削除
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  # フォロー・フォロワー一覧

  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end


end
