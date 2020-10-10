class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :unsubscribe, :withdraw]

  def show
  	@user = User.find(params[:id])
    @followings = @user.following_user.where(is_deleted: false)
    @followers = @user.follower_user.where(is_deleted: false)
  	# 退会ユーザーの情報は表示しない
  	if @user.is_deleted == true
		  redirect_to user_path(current_user)
    end
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "更新に成功しました！"
    else
      render "edit"
    end
  end

  # 退会処理
  def unsubscribe
  	@user = User.find(params[:id])
  end

  def withdraw
  	@user = User.find(params[:id])
    if @user.update(is_deleted: true)
    	sign_out current_user
	end
    redirect_to root_path, notice: "退会処理が完了しました！"
  end

  # ユーザーIDの検索結果を表示
  def search
    @users = User.all
  end

   # 自分がフォローしているユーザー一覧
  def following
    @user = User.find(params[:id])
    @followings = @user.following_user.where(is_deleted: false)
  end

  # 自分をフォローしているユーザー一覧
  def follower
    @user = User.find(params[:id])
    @followers = @user.follower_user.where(is_deleted: false)
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :is_deleted)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
