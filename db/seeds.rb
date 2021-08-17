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
