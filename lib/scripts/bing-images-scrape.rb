require 'net/https'
require 'open-uri'
require 'uri'
require 'json'

term = "Medical & Dental @ Rong An"

def scrape_bing(term)
  accessKey = '96c237bed77d49bcad12583c726d47db'

  uri  = "https://api.cognitive.microsoft.com"
  path = "/bing/v7.0/images/search"

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

  parsed_json = JSON.parse(response.body)
  parsed_json["value"].first(5).each do |result|
    result[i]
    # total_returned_images = parsed_json["totalEstimatedMatches"]

    first_result = parsed_json["value"][0]["thumbnailUrl"]
    second_result = parsed_json["value"][1]["thumbnailUrl"]
    third_result = parsed_json["value"][2]["thumbnailUrl"]
    fourth_result = parsed_json["value"][3]["thumbnailUrl"]
    fifth_result = parsed_json["value"][4]["thumbnailUrl"]


    download = open(url_string)

    IO.copy_stream(download, "#{Rails.root}/app/assets/images/hospital1.jpg")

    # puts "total number of returned matches: #{total_returned_images}"
    # puts "Url to the thumbnail of the first returned search result: #{first_result}"

  end
