# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Hospital.delete_all if Rails.env.development?


Hospital.create![image: , name: "Shanghai International Medical Center", address: "4358 Kangxin Highway, Pudong New District, Shanghai", price: 3211, open_at: "8:30", close_at: "17:00", tel:"021-60236000" ]





t.string :image
t.string :name
t.string :address
t.integer :price
t.datetime :open_at
t.datetime :close_at
t.float :longitude
t.float :latitude
:tel
