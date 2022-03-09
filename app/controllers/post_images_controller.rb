class PostImagesController < ApplicationController
  def new
    @post_image = PostImage.new
  end

  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.user_id = current_user.id
    @post_image.save
    redirect_to post_images_path
  end

  def index
    @post_images = PostImage.all
  end

  def edit
    @post_image = PostImage.find(params[:id])
  end

  def update
    post_image = PostImage.find(params[:id])
    post_image.update(post_image_params)
    redirect_to post_image_path(post_image.id)
  end

  def show
    @post_image =PostImage.find(params[:id])
  end

  def destroy
  end


  # 投稿データのストロングパラメーター
  private

  def post_image_params
    params.require(:post_image).permit(:image, :caption)
  end

end
