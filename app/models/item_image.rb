class ItemImage < ApplicationRecord

  has_one_attached :image
  belongs_to :user
  belongs_to :category
  
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end  
  
  def self.looks(word)
    if word.empty?
      @item_image = ItemImage.all
    else
      @item_image = ItemImage.where("name LIKE?", "%#{word}%")
    end
  end  

end
