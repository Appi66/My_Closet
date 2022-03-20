class PostCommentsController < ApplicationController



  def create
   @post_image = PostImage.find(params[:post_image_id])
    @comment = current_user.post_comments.new(post_comment_params)
    @comment.post_image_id = @post_image.id
    @comment_post_image = @comment.post_image
     if @comment.save
      # 通知の作成
      @comment_post_image.create_notification_post_comment!(current_user, @comment.id)
      redirect_to post_image_path(@post_image)
     else
      redirect_to post_image_path(@post_image), alert: "ERROR:コメントが空欄です"
     end
  end

  def show
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new
  end

  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to post_image_path(params[:post_image_id])
  end



  private
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
