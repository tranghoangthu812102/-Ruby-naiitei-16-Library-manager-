User.create!(name: "Million Cloud",
             email: "abc@gmail.com",
             password: "123456",
             password_confirmation: "123456",
             role: "admin")

20.times do |n|
  name = Faker::Name.name
  email = "test-#{n+1}@gmail.com"
  password = "123456"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end

30.times do |n|
  name = Faker::Lorem.word
  Category.create!(name: name)
end

# Create following relationships.
users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
