# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Hospital.delete_all if Rails.env.development?


# Hospital.create!(image: "https://www.cpgcorp.com.sg/cpgc/Content/Projects/1263/1263_04.jpg", name: "Shanghai International Medical Center", address: "4358 Kangxin Highway, Pudong New District, Shanghai", price: 3211, open_at: "8:30", close_at: "17:00", tel:"021-60236000", latitude: 31.2376, longitude: 121.5123)

# Hospital.create!(image: "https://upload.wikimedia.org/wikipedia/commons/thumb/1/16/WMC_Pinned_Crest.JPG/1200px-WMC_Pinned_Crest.JPG", name: "The 2nd Affiliated Hospital & Yuying Children’s Hospital of Wenzhou Medical University", address: "Outpatient Building, Building No. 8, 109 West Xueyuan Road, Lucheng District, Wenzhou", price: 2300, open_at: "9:00", close_at: "16:30", tel:"0577-88002926", latitude: 28.0062, longitude: 120.6722)

# Hospital.create!(image: "https://carepharmaceuticals.com.au/wp-content/uploads/sites/19/2018/02/placeholder-600x400.png", name: "Xinjiang Jia Yin Hospital International Clinic", address: "4655 Yingbin Road, New District, Urumqi", price: 1250, open_at: "10:00", close_at: "20:00", tel:"0991-3773519", latitude: 43.82500, longitude: 87.60000)




selected = Hospital.create!(image: "http://www.perkinseastman.com/dynamic/image/week/asset/liquid/1500x/92/777777/Center/3415284.jpg" , name: "Hangzhou Can Am International Medical Center" , address: "Room 301, G Zone, Building No.2, EAC Apartment, 26 Jiaogong Road, Xihu District, Hangzhou" , open_at: "8:00am", close_at: "6:00pm" , tel: "0571-87025120" , latitude: 30.2876192, longitude: 120.1307077)

selected.tag_list.add("Family medicine", "Private", "English", "CIGNA", "Physical Therapy")
selected.save

second = Hospital.create!(image: "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=152299411,3165902559&fm=26&gp=0.jpg" , name: "Dingxiang clinic" , address: "Rm 103&201-209, No.333, Lianhua Street, Xihu District,Hangzhou，Zhejiang" , open_at: "8:30am" , close_at:"5:30pm" , tel: "0571-28235136" , latitude: 30.2920034, longitude: 120.1366966)

second.tag_list.add("MSH", "Private", "English", "Family medicine", "Gynecology")
second.save


Hospital.create!(image: "http://www.indigobeijing.com/~/media/Images/indigo2015/shopping/arrail-dental-clinic/Arrail-Dental-Clinic.jpg?h=360&la=zh-CN&mh=360&w=640&hash=67569A8A7A80CD2ADA4DC041D71540EBD1B536F9" , name: "Hangzhou Arrail Dental Clinic-EAC Clinic" , address: "F203, 2F Block B, Europe and America Center, 26 Jiaogong Road, Xihu District, Hangzhou" , open_at: "10:00am" , close_at: "6:00pm", tel: "0571-81389000" , latitude: 30.285335, longitude: 120.1307617)


Hospital.create!(image: "https://www.havingababyinchina.com/wp-content/uploads/2010/09/%E5%8C%97%E4%BA%AC%E7%BE%8E%E4%B8%AD%E5%AE%9C%E5%92%8C%E5%A6%87%E5%84%BF%E5%8C%BB%E9%99%A2.jpg" , name: "Hangzhou Amcare Women & Children's Hospital" , address: "67 Gudun Road, Xihu District, Hangzhou" , open_at: "8:30am" , close_at: "5:00pm" , tel: "400-100-0016" , latitude: 30.2762249 , longitude: 120.0962718)

Hospital.create!(image: "http://upload.wikimedia.org/wikipedia/commons/a/af/The_Second_Affiliated_Hospital_of_Zhejiang_University_School_of_Medicine_6.JPG" , name: "The Second Affiliated Hospital Zhejiang University School of Medicine, International Medicine Department (Binjiang Branch)" , address: "7F Central Building, 1511 Jianghong Road, Binjiang District, Hangzhou" , open_at: "8:30am" , close_at: "5:30pm" , tel: "0571-89713988" , latitude: 30.2115, longitude: 120.21199999999999)

Hospital.create!(image: "https://travelplugged.com/wp-content/uploads/2017/09/Hospitals-Ningbo-Mingzhou-Hospital.jpg" , name: "Mingzhou Hospital" , address: "No.590. North Shixin Road, Xiaoshan District, Hangzhou, Zhejiang Province" , open_at: "8:00am" , close_at: "12:00pm" , tel: "0571-83823552" , latitude: 30.16746 , longitude: 120.25883)

Hospital.create!(image: "https://www.havingababyinchina.com/wp-content/uploads/2018/09/%E6%9D%AD%E5%B7%9E%E7%8E%9B%E5%88%A9%E4%BA%9A%E7%85%A7%E7%89%871.jpg" , name: "Hangzhou Obsterics Hospital" , address: "4th Floor, International Department , 369 Kunpeng Road, ShangCheng District, Hangzhou" , open_at: "6:30am" , close_at: "8:00pm" , tel: "0571-56005491" , latitude: 30.2447, longitude: 120.16499999999996)

Hospital.create!(image: "https://www.smithgroup.com/sites/default/files/styles/slideshow_mobile_1x/public/2018-07/Hangzhou-7th-Hospital-02.jpg?h=33c22240&itok=uDT2uD-X" , name: "Hangzhou Seventh People‘s hospital West Valley Clinic" , address: "Room 207-208, Block C, Qianjiang Zhejiang Business Venture Center, 527 Xixi Road, Xihu District, Hangzhou" , open_at: "8:00am" , close_at: "12:00pm" , tel: "0571-88633726" , latitude: 30.2582351 , longitude: 120.0806225)

Hospital.create!(image: "https://www.hdrinc.com/sites/default/files/styles/carousel_image/public/2017-05/zhejiang-university-first-affiliated-hospital-exterior-whole-complex.jpg?itok=qClo2AV-" , name: "International Medical Outpatient department, The First Affiliated Hospital, zhejiang university school of medicinel" , address: "No. 998, East WenYi Road, Yuhang District, Hangzhou, Zhejiang" , open_at: "8:30am" , close_at: "5:00pm" , tel: "400-820-0955" , latitude: 30.3828, longitude: 120.29200000000003)


puts "You've created #{Hospital.count} hospitals"



#IRINA SCENERIO
#ENGLISH "" , CIGNA, FAMILY MEDICINE, HANGZHOU
