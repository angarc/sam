# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


500.times do |i|
  type_chance = Random.rand(10) + 1
  type = nil
  case type_chance
  when 1..3
    type = :response
  when 3..6
    type = :staple
  when 6..10
    type = :pillar
  else 
    type = :response
  end

  status_chance = Random.rand(10) + 1
  status = nil
  case status_chance
  when 1..3
    status = :unwritten
  when 3..6
    status = :in_progress
  when 6..10
    status = :published
  else 
    status = :unwritten
  end

  date_chance = Random.rand(10) + 1

  Post.create(
    blog_id: Blog.first.id,
    category: Faker::Coffee.blend_name,
    primary_search_query: Faker::Marketing.buzzwords,
    title: Faker::Book.title,
    post_type: type,
    status: status,
    date_published: date_chance.month.ago,
    word_count: Random.rand(2500) + 1000
  )
end