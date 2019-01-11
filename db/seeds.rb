# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Item.create(title: 'product 1', price: 10.4, inventory_count: 8, category: 'cars')
Item.create(title: 'product 2', price: 4.0, inventory_count: 2, category: 'cars')
Item.create(title: 'product 3', price: 5.7, inventory_count: 0, category: 'cars')
Item.create(title: 'product 4', price: 2.5, inventory_count: 9, category: 'cars')
Item.create(title: 'product 5', price: 1.8, inventory_count: 7, category: 'toys')
Item.create(title: 'product 6', price: 11.5, inventory_count: 0, category: 'toys')