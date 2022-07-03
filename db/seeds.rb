# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

2.times do |i|
    User.create(email: "user-#{i+1}@example.com", password: "password", password_confirmation: "password")
end

User.all.each do |u|
  u.shifts.create(start_at: 1.day.ago, end_at: 2.days.ago + 1.hour)
  u.shifts.create(start_at: 3.day.ago, end_at: 3.days.ago + 2.hours)
  u.shifts.create(start_at: 4.day.ago, end_at: 2.days.ago)
end