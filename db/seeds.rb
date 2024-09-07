(1..10).each do |i|
  user = User.create!(
    email: "user_#{i}@gmail.com",
    password: '12345678'
  )

  youtube_id = SecureRandom.hex(32)
  user.videos.create!(
    title: "video#{i}",
    youtube_id: youtube_id,
    like: 10,
    dislike: 10,
    description: "this is video number #{i}",
    url: "https://www.youtube.com/watch?v=#{youtube_id}"
  )
end
