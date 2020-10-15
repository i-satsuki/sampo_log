# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

20.times do |n|
    User.create!(
      email: "test#{n + 1}@gmail.com",
      name: "test#{n + 1}",
      uid: "test#{n + 1}",
      password: "123456",
    )
end

User.all.each do |user|
  user.posts.create!(
    title: 'タイトル',
    body: 'テキストテキストテキストテキスト',
    steps: "8000"
  )
end
