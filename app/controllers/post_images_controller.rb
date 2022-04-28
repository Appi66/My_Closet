class PostImagesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_user, only: [:edit, :update, :destroy]

  def new
    @post_image = PostImage.new
  end

  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.user_id = current_user.id
    if @post_image.save
      redirect_to post_images_path
    else
      render :new
    end
  end

  def index
    @post_images = PostImage.all.order(created_at: :desc).page(params[:page])

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
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new
  end

  def destroy
    @post_image = PostImage.find(params[:id])
    @post_image.destroy
    redirect_to post_images_path
  end


  # 投稿データのストロングパラメーター
  private

  def post_image_params
    params.require(:post_image).permit(:image, :caption)
  end

  def ensure_user
    @post_images = current_user.post_images
    @post_image = @post_images.find_by(id: params[:id])
    redirect_to post_images_path unless @post_image
  end



end
