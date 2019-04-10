require 'csv'

bills = CSV.open('../../bill.csv')
bills = bills.read

CSV.open("../../cn_new_bill.csv", "wb") do |csv|
  csv << ["city", "special provider", "provider type", "name", "specialties", "address", ]

  bills.each do |row|
    new_row = []
    # CITY
    city = row[0]
    city.gsub!("长春 Changchun", "长春\nChangchun")
    new_row << city.match(/(.*)\n/)[1]

    # SPECIAL PROVIDER? (Y/N)
    special_provider = row[2]
    if special_provider.nil?
      temp = "n/a"
    else
      temp = special_provider.split(" ")[0]
    end
    new_row << temp

    # PROVIDER TYPE (Private/Public/Wellness/Dental)
    provider_type = row[3]
    provider_type.gsub!("私立医疗机构 Private Providers", "私立医疗机构\nPrivate Providers")
    new_row << provider_type.match(/(.*)\n/)[1]

    # NAME
    hospital_name = row[5]
    new_row << hospital_name.match(/(.*)\n/)[1]

    # SPECIALTY TODO: STILL HAVE ANOMOLIES
    specialty = row[6]
    if specialty.nil?
      temp = "n/a"
    elsif specialty.include?("\n")
      temp = specialty.match(/(.*)\n/)[1]
    elsif specialty =~ /\p{Han}\w/
      temp = specialty.split(/\p{Han}\w/)[0]
    elsif specialty =~ /\p{Han}/
      temp = specialty.split(" ")[0]
      # else
      # specialty[6]
    end
    new_row << temp

    #ADDRESS
    # address = row[7]
    # if address =~ /\p{Han}\w/
    #   p address
    #   # p temp = address.split(/\p{Han}\w/)[0]
    # elsif address.include?("\n")
    #   temp = address.match(/(.*)\n/)[1]
    # end
    # new_row << temp


    # WEEKDAY MON-FRI
    weekday = row[8]
    if weekday.nil?
      temp = "n/a"
    else
      cn_eng = weekday.split("\n")
      temp = cn_eng.reject { |item| item.match(/\p{Han}/) }.join(" ")
    end
    new_row << temp

    # elsif weekday.include?("Full day")
    #   temp = "24h"
    # elsif weekday.count("\n") == 1
    #   temp = weekday.match(/\n(.*)/)[1]
    # elsif weekday.count("\n") == 2
    #   weekday
    # elsif weekday.count("\n") == 3
    #   weekday
    # elsif weekday.count("\n") == 4
    #   weekday
    # elsif weekday.count("\n") == 5
    #   item = weekday.split("\n")
    #   item.reject do |item|
    #     if item[0] =~ /\p{Han}\w/
    #       item.delete(item)
    #     end

    #     elsif weekday.count("\n") == 7
    #       eng = weekday.split("\n")
    #       temp = eng[4] + " " + eng[5] + " " + eng[6] + " " + eng[7]
    #     else
    #       weekday
    #       # weekday.gsub!(/\p{Han}/, '')
    #       # p weekday.match(/(\d*:\d0\s?(am|pm) [-|–] \d*:\d*\s?(am|pm))/)[
    #     end



    #WEEKEND SAT-SUN
    weekend = row[9]
    if weekend.nil?
      temp = "n/a"
    else
      cn_eng = weekend.split("\n")
      temp = cn_eng.reject { |item| item.match(/\p{Han}/) }.join(" ")
    end
    new_row << temp

    #TEL
    tel = row[10]
    if tel.nil?
      temp = "n/a"
    else
      tel.gsub!("个险 IPMI", "Individual")
      tel.gsub!("团险 CGHB", "Group")
      tel.gsub!("英", "Eng")
      tel.gsub!("转", "ext.")
      tel.gsub!(/\p{Han}/, "")
      tel.gsub!("\，", '')
      tel.gsub!("\。", '')
      tel.delete!("24小时服务中心")
      tel.delete!("(仅对保险公司开放)")
    end
    new_row << tel
    # p tel


    #FOREIGN LANGUAGE SERVICE
    lang = row[12]
    if lang.nil?
      lang = ""
    else
      lang.gsub!(/\p{Han}/, '')
      lang.gsub!("\，", '')
      lang.gsub!("\。", '')
      lang.gsub!("/English", "Eng")
      lang.gsub!("/Japanese", "Jp")
      lang.gsub!("/Korean", "Kr")
      lang.gsub!("/Chinese", "Cn")
      lang.gsub!("/German", "Ger")
      lang.gsub!("/French", "Fr")
      lang.gsub!("/ French", "Fr")
      lang.gsub!("/Spanish", "Span")
      lang.gsub!("/Russian", "Ru")
      lang.gsub!("/ Cantonese", "Canto")
      lang.gsub!("/Farsi", "Farsi")
      lang.gsub!("/Dutch", "Dutch")
      lang.gsub!("/Filipino", "Filipino")
    end
    new_row << lang

    #APPOINTMENT RECOMMENDED
    app_rec = row[14]
    if app_rec.nil?
      tem = ""
    elsif app_rec.include?("make appointment")
      tem = "Yes"
    elsif app_rec.include?("Cigna & CMB")
      app_rec.gsub!(/\p{Han}/, '')
      app_rec.gsub!("\，", '')
      app_rec.gsub!("\。", '')
      tem = app_rec.gsub!("Cigna & CMB", "insurer's")
    else
      tem = ""
    end
    new_row << tem


    csv << new_row
  end
end


















# # SPECIAL PROVIDER(High Cost Providers)
# # test = []
# bills.each do |cost|
#   if cost[2].nil?
#     temp = "n/a"
#   else
#     temp = cost[2].split(" ")[0]
#   end
#   temp
#   # test << temp
# end
# # p test.length


# #TYPE OF PROVIDER
# # test = []
# bills.each do |provider_type|
#   provider_type[3].gsub!("私立医疗机构 Private Providers", "私立医疗机构\nPrivate Providers")
#   provider_type[3].match(/(.*)\n/)[1]
#   # p provider_type[3].nil?
#   # test << provider_type[3]
# end
# # p test.length



# #HOSPITAL NAME
# # test = []
# bills.each do |hospital_name|
#   hospital_name[5].match(/(.*)\n/)[1]
#   # test << hospital_name[5]
# end
# # p test.size


# #SPECIALTIES TODO: not clean yet
# # test = []
# bills.each do |specialty|
#   if specialty[6].nil?
#     temp = "n/a"
#   elsif specialty[6].include?("\n")
#     temp = specialty[6].match(/(.*)\n/)[1]
#   elsif specialty[6] =~ /\p{Han}\w/
#     temp = specialty[6].split(/\p{Han}\w/)[0]
#   elsif specialty[6] =~ /\p{Han}/
#     temp = specialty[6].split(" ")[0]
#     # else
#     #   specialty[6]
#   end
#   temp
#   # test << specialty[6]
#   # p test.size
# end

# #ADDRESS
# # test = []
# bills.each do |address|
#   if address[7] =~ /\p{Han}\w/
#     temp = address[7].split(/\p{Han}\w/)[0]
#   elsif address[7].include?("\n")
#     temp = address[7].match(/(.*)\n/)[1]
#   end
#   temp
#   # test << temp
# end
# # p test.size


# #MON-FRI
# # test = []
# bills.each do |weekday|
#   if weekday[8].nil?
#     temp = "n/a"
#   elsif weekday[8].include?("\n")
#     temp = weekday[8].split("\n")
#     # .match(/(.*)\n/)[1]
#     # end
#     # temp
#     # test << temp
#   end
# end

# #anomolies:
# # "门诊OP\n上午 9:00 - 下午 18:00 \n9:00-18:00 小儿皮肤科 Pediatric dermatology\n上午 9:00 - 下午 19:00"
# # "门诊OP\n上午 8:00 - 下午 17:00\n急诊Emergency\n下午 17:00 - 上午 8:00"
# # "早上 8:30 至 11:30，下午 1:30 至 5:00\n（请提前2天预约）\n8:30 am - 11:30 am, 1:30 pm - 5:00 pm\n(Please make appointment two days in advance)"
# # \d*:\d0\s?(am|pm) (-|–) \d*:\d*\s?(am|pm)
