User.destroy_all
Post.destroy_all

users = []

5.times do |i|
  users << User.create!(
    email: "user#{i+1}@example.com",
    password: 'password',
    password_confirmation: 'password'
  )
end

users.each do |user|
  5.times do |i|
    Post.create!(
      title: "Sample Post #{i+1} by #{user.email}",
      body: "This is the body of sample post #{i+1} by #{user.email}",
      created_at: Time.now,
      user: user
    )
  end
end
