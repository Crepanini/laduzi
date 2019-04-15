require 'csv'

bills = CSV.open('../../bill.csv')
bills = bills.read

#CHINESE
CSV.open("../../cn_new_bill.csv", "wb") do |csv|
  csv << ["城市", "特定医院", "医院性质", "医疗机构", "特色科室", "地址", "周一至周五", "周六至周日", "预约电话", "外语服务", "备注", "网址"]

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
    hospital_name.gsub!("*", "")
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
    address = row[7]
    addr = address.split("\n").select { |item| item.match(/\p{Han}/) }.join(" ")
    new_row << addr
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

    #WEBSITE
    website = row[15]
    if website.nil? || website == "无"
      web = ""
    else
      web = website
    end
    new_row << website

    csv << new_row
  end
end

# English
CSV.open("../../eng_new_bill.csv", "wb") do |csv|
  csv << ["city", "district", "special provider", "provider type", "name", "specialties", "address", "mon-fri", "sat-sun", "appointment tel", "foreign lang. service", "appointment recommended", "website", "cn_address", "lat", "long"]

  bills.each do |row|
    new_row = []
    # CITY
    city = row[0]
    new_row << city.match(/\n(.*)/)[1]

    # DISTRICT
    district = row[1]
    if district.nil?
      temp = ""
    else
      temp = district.split("\n")[1]
    end
    new_row << temp

    # SPECIAL PROVIDER? (Y/N)
    special_provider = row[2]
    if special_provider.nil?
      temp = "n/a"
    else
      temp = special_provider.split(" ")[1]
    end
    new_row << temp

    # PROVIDER TYPE (Private/Public/Wellness/Dental)
    provider_type = row[3]
    temp = provider_type.split("\n").reject { |item| item.match(/\p{Han}/) }.join(" ")
    temp.gsub!("Private Providers", "Private")
    temp.gsub!("Dental Clinic", "Dental")
    temp.gsub!("Public Hospitals", "Public")
    new_row << temp

    # HOSPITAL NAME
    hospital_name = row[5]
    hospital_name.gsub!("*", "")
    temp = hospital_name.split("\n").reject { |item| item.match(/\p{Han}/) }.join(" ")
    new_row << temp

    # SPECIALTY
    specialty = row[6]
    if specialty.nil?
      temp = ""
    elsif specialty.count("\n").zero?
      temp = specialty.split(" ").reject { |item| item.match(/\p{Han}/) }.join(" ")
    else
      temp = specialty.split(" ").reject { |item| item.match(/\p{Han}/) }.join(" ")
    end
    new_row << temp
    # if specialty.include?("\n")
    #   p specialty
    # end

    #ADDRESS
    address = row[7]
    addr = address.split("\n").reject { |item| item.match(/\p{Han}/) }.join(" ")
    new_row << addr


    # WEEKDAY MON-FRI
    weekday = row[8]
    if weekday.nil?
      temp = "n/a"
    else
      cn_eng = weekday.split("\n")
      temp = cn_eng.reject { |item| item.match(/\p{Han}/) }.join(" ")
    end
    new_row << temp

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


    #WEBSITE
    website = row[15]
    if website.nil? || website == "无"
      web = ""
    else
      web = website
    end
    new_row << website

    #CN_ADDRESS
    cn_address = row[7]
    addr = cn_address.split("\n").select { |item| item.match(/\p{Han}/) }.join(" ")
    new_row << addr

    #LONG & LAT
    require 'json'
    require 'open-uri'
    address_encode = URI.encode("#{addr}output=JSON&key=9b57c5123cd0de1872cd123bf5f440c9")
    url = "https://restapi.amap.com/v3/geocode/geo?address=#{address_encode}"
    serialize = open(url).read
    parse = JSON.parse(serialize)
    location = parse["geocodes"][0]["location"].split(",")
    lat = location[1]
    new_row << lat
    long = location[0]
    new_row << long

    csv << new_row
  end
end
