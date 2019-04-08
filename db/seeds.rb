# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Hospital.delete_all if Rails.env.development?


Hospital.create![image: , name: ]




# create_table "hospitals", force: :cascade do |t|
#   t.string "image"
#   t.string "name"
#   t.string "addressraill"
#   t.integer "price"
#   t.datetime "open_at"
#   t.datetime "close_at"
#   t.float "longitude"
#   t.float "latitude"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
