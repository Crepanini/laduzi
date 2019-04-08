# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Hospital.delete_all if Rails.env.development?


Hospital.create!(image: "https://www.cpgcorp.com.sg/cpgc/Content/Projects/1263/1263_04.jpg", name: "Shanghai International Medical Center", address: "4358 Kangxin Highway, Pudong New District, Shanghai", price: 3211, open_at: "8:30", close_at: "17:00", tel:"021-60236000", latitude: 31.2376, longitude: 121.5123)

Hospital.create!(image: "https://upload.wikimedia.org/wikipedia/commons/thumb/1/16/WMC_Pinned_Crest.JPG/1200px-WMC_Pinned_Crest.JPG", name: "The 2nd Affiliated Hospital & Yuying Children’s Hospital of Wenzhou Medical University", address: "Outpatient Building, Building No. 8, 109 West Xueyuan Road, Lucheng District, Wenzhou", price: 2300, open_at: "9:00", close_at: "16:30", tel:"0577-88002926", latitude: 28.0062, longitude: 120.6722)

Hospital.create!(image: "https://carepharmaceuticals.com.au/wp-content/uploads/sites/19/2018/02/placeholder-600x400.png", name: "Xinjiang Jia Yin Hospital International Clinic", address: "4655 Yingbin Road, New District, Urumqi", price: 1250, open_at: "10:00", close_at: "20:00", tel:"0991-3773519", latitude: 43.82500, longitude: 87.60000)


puts "You've created #{Hospital.count} hospitals"
