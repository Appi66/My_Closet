class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @user = User.find(current_user.id)
    @item_images = ItemImage.looks(params[:word]).where(user: @user).order(created_at: :desc)
  end
end
