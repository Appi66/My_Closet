class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images.order(created_at: :desc).page(params[:page])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_image_id)
    @favorite_post_images = PostImage.find(favorites)
    @favorite_post_images = Kaminari.paginate_array(@favorite_post_images).page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to :root
  end

  def withdraw
  end

  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_image_id)
    @favorite_post_images = PostImage.find(favorites)
    @favorite_post_images = Kaminari.paginate_array(@favorite_post_images).page(params[:page])
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
