# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.new(
  name: 'Some',
  lastname: 'One',
  email: 'rvillagrana@protonmal.com',
  password: '123456'
)
user.save

10.times do |n|
  list = User.first.lists.new(
    name: "List #{n}",
    description: 'Description'
  )
  list.save
  10.times do |m|
    list.tasks.new(
      name: "Task #{n * m}",
      done: Random.rand(2)
    ).save
  end
end
