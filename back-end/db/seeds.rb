puts "Seeding sample data..."

# create 50 users
50.times do
  User.create(
    username: Faker::Internet.username,
    email: Faker::Internet.email
  )
end

# create 20 restaurants
20.times do
  Restaurant.create(
    name: Faker::Restaurant.name,
    address: Faker::Address.street_address
  )
end

# create 200 reviews
200.times do
  Review.create(
    user_id: rand(User.first.id..User.last.id),
    restaurant_id: rand(Restaurant.first.id..Restaurant.last.id),
    comment: Faker::Lorem.paragraph
  )
end

# create 100 favorites
100.times do
  Favorite.create(
    user_id: rand(User.first.id..User.last.id),
    restaurant_id: rand(Restaurant.first.id..Restaurant.last.id)
  )
end

# create 25 fake reviews associated with random users
25.times do
  AppReview.create!(
    comment: Faker::Lorem.sentence,
    star_rating: rand(1..5),
    user_id: rand(User.first.id..User.last.id)
  )
end


puts "Done seeding!"