puts "Seeding sample data..."

# create 50 users
50.times do
  User.create(
    username: Faker::Internet.username,
    email: Faker::Internet.email,
    password: '123456'
  )
end

# create 25 fake reviews associated with random users
25.times do
  AppReview.create(
    comment: Faker::Lorem.sentence,
    user_id: rand(User.first.id..User.last.id)
  )
end

# create 20 restaurants
20.times do
  Restaurant.create(
    name: Faker::Restaurant.name,
    address: Faker::Address.street_address
  )
end

# create 100 favorites
100.times do
  Favorite.create(
    user_id: rand(User.first.id..User.last.id),
    restaurant_id: rand(Restaurant.first.id..Restaurant.last.id)
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

# create 250 tables
250.times do
  Table.create(
    name:  Faker::Lorem.words(number: 2).join(' '),
    restaurant_id: rand(Restaurant.first.id..Restaurant.last.id),
    capacity: rand(1..12),
    description: Faker::Lorem.paragraph
  )
end

#create 1000 reservations
1000.times do
  Reservation.create(
    user_id: rand(User.first.id..User.last.id),
    restaurant_id: rand(Restaurant.first.id..Restaurant.last.id),
    table_id: rand(Table.first.id..Table.last.id),
    num_clients: rand(1..Table.last.capacity),
    time: Time.now + rand(1..30).hours,
    date: Date.today + rand(1..30).days,
    comment: Faker::Lorem.paragraph
  )
end


puts "Done seeding!"