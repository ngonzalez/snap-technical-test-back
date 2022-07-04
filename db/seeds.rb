# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

2.times do |i|
  User.create!(email: Faker::Internet.email, password: "password", password_confirmation: "password")
end

User.find_each do |user|
  user.shifts.create!(start_at: 10.days.ago, end_at: 10.days.ago + 1.hour)
  user.shifts.create!(start_at: 3.day.ago, end_at: 3.days.ago + 2.hours)
  user.shifts.create!(start_at: 4.day.ago, end_at: 2.days.ago)
end

User.all.each do |user|
  user.csv_exports.create!
end