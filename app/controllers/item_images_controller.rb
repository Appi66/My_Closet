class ItemImagesController < ApplicationController
  def new
    @item_image = ItemImage.new
  end

  def create
    @item_image = ItemImage.new(item_image_params)
    @item_image.user_id = current_user.id
    if @item_image.save
      redirect_to item_images_path
    else
      render :new
    end
  end

  def index
    @user = User.find(current_user.id)
    @item_images = @user.item_images.order(created_at: :desc).page(params[:page])
    @categories = Category.all
    if params[:category_id].present?
      @category = Category.find(params[:category_id])
      @item_images = @category.item_images.where(user: @user).order(created_at: :desc).page(params[:page])
    end
  end

  def show
    @item_image = ItemImage.find(params[:id])
  end

  def edit
    @item_image = ItemImage.find(params[:id])
  end

  def update
    item_image = ItemImage.find(params[:id])
    item_image.update(item_image_params)
    redirect_to item_image_path(item_image.id)
  end

  def destroy
    @item_image = ItemImage.find(params[:id])
    @item_image.destroy
    redirect_to item_images_path
  end

  # アイテム追加時のストロングパラメーター
  private

  def item_image_params
    params.require(:item_image).permit(:image, :name, :brand_name, :category_id)
  end

end
