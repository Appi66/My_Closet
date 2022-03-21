class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images.order(created_at: :desc).page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(current_user.id)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to :root
  end

  def withdraw
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
