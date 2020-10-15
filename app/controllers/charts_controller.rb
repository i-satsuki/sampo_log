class ChartsController < ApplicationController
  before_action :authenticate_user!

  def monthly
    # pre_previewのパラメータが入っていれば、1ヶ月"前"を@target_monthに入れる
    if params[:pre_preview].present?
      @target_month = Date.parse(params[:pre_preview]) << 1
    # next_previewのパラメータが入っていれば、1ヶ月"後"を@target_monthに入れる
    elsif params[:next_preview].present?
      @target_month = Date.parse(params[:next_preview]) >> 1
    # それ以外は、現在の日付を@target_monthに入れる
    else
      @target_month = Time.current.to_date
    end

    # current_userがフォローしているユーザー＝follower_idがcurrent_userであるユーザー
    # pluckでfollowed_id（フォローしているユーザーのID）を配列する
    # pushでフォローしているユーザーに加えて、自分の情報も表示させる
    target_user = Relationship.where(follower_id: current_user.id).pluck(:followed_id).push(current_user.id)

    # joinsメソッドでusersテーブルとpostsテーブルを 内部結合する
    # whereメソッドで1ヶ月のデータと退会していないユーザーを絞り込む
    # groupメソッドでユーザーごとにレコードをまとめる
    # orderメソッドで歩数（steps）の多い順にユーザーを並び替える
    @users = User.joins(:posts)
    .where(id: target_user)
    .where(posts: { created_at: @target_month.all_month })
    .where(users: { is_deleted: false })
    .group(:id).order("sum(posts.steps) desc")
  end
end
