# Fullcalendarに歩数を表示する（クリックしたら投稿詳細ページに遷移する）
json.array!(@posts) do |post|
  json.id "#{post.id}"
  json.title "#{post.steps}歩"
  json.start post.created_at
  json.url post_url(post, format: :html)
end
