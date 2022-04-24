class Favorite < ApplicationRecord

  belongs_to :user
  belongs_to :post_image


    # いいねの通知
  def create_notification_by(current_user)
    notification = current_user.active_notifications.new(
      post_image_id: id,
      visited_id: user_id,
      action: "favorite"
      )
    notification.save if notification.valid?
  end

end
