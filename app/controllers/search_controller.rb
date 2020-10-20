class SearchController < ApplicationController
  # 完全一致のみ検索結果が表示される
  def search
    @content = params["search"]["content"]
    @records = search_for(@content)
  end

  # 検索結果に退会ユーザーは表示しない
  def search_for(content)
    User.where(uid: content, is_deleted: :false)
  end
end
