class CreateItemImages < ActiveRecord::Migration[6.1]
  def change
    create_table :item_images do |t|
      t.integer :user_id
      t.integer :category_id
      t.string :name
      t.string :brand_name

      t.timestamps
    end
  end
end
