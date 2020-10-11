class CommentsController < ApplicationController
	before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
    	redirect_to request.referer, notice: "コメントを記録しました！"
	end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
    	redirect_to request.referer, notice: "コメントを削除しました！"
	end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :post_id, :user_id)
  end

end
