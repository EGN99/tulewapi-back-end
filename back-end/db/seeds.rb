puts "Seeding sample data..."

# create 10 users
10.times do
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email
  )
end

# create 10 restaurants
10.times do
  Restaurant.create(
    name: Faker::Restaurant.name,
    address: Faker::Address.street_address
  )
end

# create 50 reviews
50.times do
  Review.create(
    user_id: rand(User.first.id..User.last.id),
    restaurant_id: rand(Restaurant.first.id..Restaurant.last.id),
    comment: Faker::Lorem.paragraph
  )
end

# create 20 favorites
20.times do
  Favorite.create(
    user_id: rand(User.first.id..User.last.id),
    restaurant_id: rand(Restaurant.first.id..Restaurant.last.id)
  )
end

puts "Done seeding!"