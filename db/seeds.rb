# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# PRODUCT
Product.destroy_all
product1 = Product.create({name: "STAGE 1 SEMAINE", price: 350, duration_in_days: 7})
product2 = Product.create({name: "STAGE 1 MOIS", price: 900, duration_in_days: 31})
product3 = Product.create({name: "STAGE 3 MOIS", price: 2200, duration_in_days: 92})

puts "Total number of products: #{Product.all.count}"
puts "Product names: #{Product.all.pluck('name')}"
puts "Product1: #{product1.name} price: #{product1.price.round(2)} duration (in days): #{product1.duration_in_days}"
puts "Product2: #{product2.name} price: #{product2.price.round(2)} duration (in days): #{product2.duration_in_days}"
puts "Product3: #{product3.name} price: #{product3.price.round(2)} duration (in days): #{product3.duration_in_days}"

# CART
Cart.destroy_all
puts "\nTotal cart count: #{Cart.all.count}"

# ROOM
Room.destroy_all
room1 = Room.create({number: 1, booked: false})
room2 = Room.create({number: 2, booked: false})
room3 = Room.create({number: 3, booked: false})
room4 = Room.create({number: 4, booked: false})
room5 = Room.create({number: 5, booked: false})
room6 = Room.create({number: 6, booked: false})
room7 = Room.create({number: 7, booked: false})
room8 = Room.create({number: 8, booked: false})

puts "Total number of rooms: #{Product.all.count}"
puts "Room 1: #{room1.number} booked: #{room1.booked}"
puts "Room 2: #{room2.number} booked: #{room2.booked}"
puts "Room 3: #{room3.number} booked: #{room3.booked}"
puts "Room 4: #{room4.number} booked: #{room4.booked}"
puts "Room 5: #{room5.number} booked: #{room5.booked}"
puts "Room 6: #{room6.number} booked: #{room6.booked}"
puts "Room 7: #{room7.number} booked: #{room7.booked}"
puts "Room 8: #{room8.number} booked: #{room8.booked}"

# DISCOUNT
Discount.destroy_all
discount1 = Discount.create({name: "NOMADSLIM", percentage: 5, amount: 0})

puts "Total number of discounts: #{Discount.all.count}"
puts "Discount1: #{discount1.name} percentage: #{discount1.percentage} amount: #{discount1.amount}"

# ADMIN USER
AdminUser.create!(email: ENV["ADMIN_USERNAME"], password: ENV["ADMIN_PASSWORD"], password_confirmation: ENV["ADMIN_PASSWORD"]) if Rails.env.production?
