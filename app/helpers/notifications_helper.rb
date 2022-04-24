module NotificationsHelper

  def notification_form(notification)
    @visiter = notification.visiter
    @comment = nil
    your_post_image = link_to 'あなたの投稿', post_image_path(notification)
    @visiter_comment = notification.post_comment_id
    # notification.actionがfollowかfavoriteかcommentか
    case notification.action
      when "follow" then
        tag.a(notification.visiter.name, href:user_path(@visiter))+"さんがあなたをフォローしました"
      when "favorite" then
        tag.a(notification.visiter.name, href:user_path(@visiter))+"さんが"+tag.a('あなたの投稿', href:post_image_path(notification.post_image_id))+"にいいねしました"
      when "post_comment" then
        @comment = PostComment.find_by(id: @visiter_comment)&.comment
        tag.a(@visiter.name, href:user_path(@visiter))+"さんが"+tag.a('あなたの投稿', href:post_image_path(notification.post_image_id))+"にコメントしました"
    end
  end

  # 未確認の通知があるときはマークで知らせる
  def unchecked_nortifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
