require 'net/https'
require 'open-uri'
require 'uri'
require 'json'


IMAGE_URLS = JSON.parse(File.read("#{Rails.root}/lib/scripts/image_urls.json"))

# urls.each do |url|
#     download = open(url)
#     count += 1
#     IO.copy_stream(download, "#{Rails.root}/app/assets/images/hospitals/#{hospital.name}_#{count}.jpg")
#     # end

count = 0
IMAGE_URLS.each do |key, value|
  if key == key
    count += 1
    download = open(value)
    IO.copy_stream(download, "#{Rails.root}/app/assets/images/hospitals/#{key}_#{count}.jpg")
  else
    count
  end
