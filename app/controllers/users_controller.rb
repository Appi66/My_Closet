class UsersController < ApplicationController
  before_action :authenticate_user!
  # before_action :ensure_user, only: [:edit, :update, :destroy]

  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images.order(created_at: :desc).page(params[:page])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_image_id)
    @favorite_post_images = PostImage.find(favorites)
    @favorite_post_images = Kaminari.paginate_array(@favorite_post_images).page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to  post_images_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to post_images_path
    elsif @user.update(user_params)
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(current_user.id)
    # if @user != current_user
    #   redirect_to post_images_path
    # else
      @user.destroy
      redirect_to :root
    # end
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

  # def ensure_user
  #   @user = current_user
  #   @user = @user.find_by(id: params[:id])
  #   redirect_to post_images_path unless @user

  # end

  # def ensure_user
  #   @users = User.all
  #   @user = current_user
  #   redirect_to post_images_path unless @user
  # end

end
