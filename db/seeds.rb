# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

10.times do
  User.create(email: Faker::Internet.email, password: '123456')
end

categories = ['Technology', 'Travel', 'Lifestyle', 'Fashion', 'Food']
categories.each do |category_name|
  Category.find_or_create_by(name: category_name)
end

10.times do
  post = Post.new(title: 'asdf', content: 'asdf')
  post.user = User.all.sample
  post.save
  # post = Post.create(title: 'asdf', content: 'asdf', user: User.all.sample)

  rand(1..5).times do
    category = Category.all.sample
    next if post.categories.include? category

    post.categories << category
  end
end
