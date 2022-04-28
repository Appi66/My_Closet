class PostCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_user, only: [:destroy]

  def index
    @post_image = PostImage.find(params[:post_image_id])
    @post_comment = PostComment.new

  end


  def create
    @post_image = PostImage.find(params[:post_image_id])
    @comment = current_user.post_comments.new(post_comment_params)
    @comment.post_image_id = @post_image.id
    @comment_post_image = @comment.post_image
     if @comment.save
      # 通知の作成
      @comment_post_image.create_notification_post_comment!(current_user, @comment.id)
     else
      redirect_to post_image_post_comments_path(@post_image), alert: "ERROR:コメントが空欄です"
     end
  end

  def show
    @post_image = PostImage.find(params[:id])

  end

  def destroy
    @post_image = PostImage.find(params[:post_image_id])
    PostComment.find(params[:id]).destroy
  end



  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

  def ensure_user
    @post_comments = current_user.post_comments
    @post_comment = @post_comments.find_by(id: params[:id])
    redirect_to post_images_path unless @post_comment
  end

end
