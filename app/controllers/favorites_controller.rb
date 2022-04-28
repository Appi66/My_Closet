class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post_image = PostImage.find(params[:post_image_id])
    favorite = current_user.favorites.new(post_image_id: @post_image.id)
    favorite.save
    # 通知の作成
    @post_image.create_notification_by(current_user)
    # redirect_back(fallback_location: root_path)
  end

  def destroy
    @post_image = PostImage.find(params[:post_image_id])
    favorite = current_user.favorites.find_by(post_image_id: @post_image.id)
    favorite.destroy
    # redirect_back(fallback_location: root_path)
  end

end
