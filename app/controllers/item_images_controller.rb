class ItemImagesController < ApplicationController
  def new
    @item_image = ItemImage.new
  end

  def create
    @item_image = ItemImage.new(item_image_params)
    @item_image.user_id = current_user.id
    @item_image.save
    redirect_to item_images_path
  end

  def index
    @item_images = ItemImage.all
  end

  def show
    @item_image = ItemImage.find(params[:id])
  end

  def edit
  end

  # アイテム追加時のストロングパラメーター
  private

  def item_image_params
    params.require(:item_image).permit(:image, :name, :brand_name, :category_id)
  end

end
