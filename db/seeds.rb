# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Cart.create(userID: 1, title: "Cards against Huamnity", price: 5.00, weight: 2.5, deliveryDays: 3)
Cart.create(userID: 1,title: "Gloomhaven", price: 100.0, weight: 10,  deliveryDays: 1)
Cart.create(userID: 1,title: "Exploding Kitten", price: 2.00, weight: 1.0,  deliveryDays: 3)
Cart.create(userID: 1,title: "Port Royal", price: 2.00, weight: 1.5,  deliveryDays: 1)
Cart.create(userID: 1,title: "Flash Point", price: 25.00, weight: 5,  deliveryDays: 8)

