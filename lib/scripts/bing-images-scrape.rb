require 'net/https'
require 'open-uri'
require 'uri'
require 'json'

RESULT = JSON.parse(File.read("#{Rails.root}/lib/scripts/results.json"))

def scrape_bing(hospital)
  accessKey = '96c237bed77d49bcad12583c726d47db'

  uri  = "https://api.cognitive.microsoft.com"
  path = "/bing/v7.0/images/search"
  term = hospital.name

  uri = URI(uri + path + "?q=" + URI.escape(term))

  request = Net::HTTP::Get.new(uri)
  request['Ocp-Apim-Subscription-Key'] = accessKey

  response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
    http.request(request)
  end

  response.each_header do |key, value|
    # header names are lowercased
    if key.start_with?("bingapis-") or key.start_with?("x-msedge-") then
      puts key + ": " + value
    end
  end

  RESULT[hospital.name] = JSON.parse(response.body)
  File.open("#{Rails.root}/lib/scripts/results.json", 'wb') do |file|
    file.write(JSON.generate(RESULT))
  end
  # save on each iteration




  urls = []
  parsed_json["value"].first(3).each do |result|
    urls << result["contentUrl"]
  end

  urls.each do |url|
    download = open(url)
    count += 1
    IO.copy_stream(download, "#{Rails.root}/app/assets/images/hospitals/#{hospital.name}_#{count}.jpg")
  end
end

num_hospitals = 0
Hospital.all[0..-1].each_with_index do |hospital, i|
  next if RESULT[hospital.name].present?
  scrape_bing(hospital)
  puts "You've scraped #{num_hospitals += 1} hospitals"
  puts hospital.name
  sleep 1
end

# total_returned_images = parsed_json["totalEstimatedMatches"]
# download = open(url_string)

# puts "total number of returned matches: #{total_returned_images}"
# puts "Url to the thumbnail of the first returned search result: #{first_result}"

# end
