class Admin::PostsController < ApplicationController
	before_action :authenticate_admin!

	def index
		# ユーザー詳細から遷移したユーザーごとの投稿一覧とヘッダーから遷移した全投稿一覧
		if params["user"]
			@user = User.find_by(id: params[:user])
	    	@posts = @user.posts.page(params[:page]).per(10)
    	else
			@posts = Post.page(params[:page]).per(10)
		end
	end

	def show
		@post = Post.find(params[:id])
		@comments = @post.comments.order(created_at: :desc)
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
    	redirect_to admin_posts_path, notice: "削除に成功しました！"
	end
end
