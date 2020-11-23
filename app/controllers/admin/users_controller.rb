class Admin::UsersController < ApplicationController
	before_action :authenticate_admin!
	before_action :set_user, except: [:index]

	def index
		@users = User.page(params[:page]).per(10)
	end

	def show
		@followings = @user.following_user.where(is_deleted: false)
    	@followers = @user.follower_user.where(is_deleted: false)

    	# 目標達成率 (to_fで型を小数にすることで計算を可能にする。)
	    posts = Post.all
	    achievement = @user.posts.where(created_at: Time.now.all_week).sum(:steps)
	    if !@user.target_number.nil?
	      @achievement_rate = (achievement.to_f / @user.target_number.to_f * 100).round
	    end
	end

	def valid
		if @user.update(is_deleted: false)
	      redirect_to admin_user_path(@user), notice: "会員ステータスを「有効」に切り替えました！"
	    end
	end

	def invalid
		if @user.update(is_deleted: true)
	      redirect_to admin_user_path(@user), notice: "会員ステータスを「無効」に切り替えました！"
	    end
	end

	# 自分がフォローしているユーザー一覧
	def following
		@followings = @user.following_user.where(is_deleted: false)
	end

	# 自分をフォローしているユーザー一覧
	def follower
		@followers = @user.follower_user.where(is_deleted: false)
	end

	private

	def user_params
		params.require(:user).permit(:is_deleted)
	end

	def set_user
		@user = User.find(params[:id])
	end
end
