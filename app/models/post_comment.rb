class PostComment < ApplicationRecord
  
  belongs_to :user
  belongs_to :post_image
  
  # バリデーション　コメント空欄不可
  validates :comment, presence: true
  
end
