class ChartsController < ApplicationController
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

	  #joinsメソッドでusersテーブルとpostsテーブルを 内部結合する
	  # whereメソッドで1ヶ月のデータと退会していないユーザーを絞り込む
	  # groupメソッドでユーザーごとにレコードをまとめる
	  # orderメソッドで歩数（steps）の多い順にユーザーを並び替える
	  @users = User.joins(:posts)
	  .where(posts: {created_at: @target_month.all_month})
	  .where(users: {is_deleted: false})
	  .group(:id)
	  .order('count(posts.steps) desc')
  end
end
