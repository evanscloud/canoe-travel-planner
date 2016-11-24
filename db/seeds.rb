# User test account
User.create(username: "MasterQ", email: "master.q@email.com", password: "password1", password_confirmation: "password1")

# User accounts
50.times do
  User.create(
    username: Faker::Internet.user_name,
    email: Faker::Internet.email,
    password: "password1",
    password_confirmation: "password1"
  )
end

# lists
300.times do
  List.create(
    title: Faker::Lorem.word,
    content: Faker::Hipster.paragraph(4),
    trip_id: Faker::Number.between(1, 200)
  )
end

# trips
200.times do
  Trip.create(
    name: Faker::Space.agency,
    location: Faker::Pokemon.location,
    user_id: Faker::Number.between(1, 51)
  )
end
