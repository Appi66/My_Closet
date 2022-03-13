class AddPostImageIdToPostImage < ActiveRecord::Migration[6.1]
  def change
    add_column :post_images, :post_image_id, :integer
  end
end
