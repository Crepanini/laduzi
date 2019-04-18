require 'open-uri'
require "net/http"
require 'openssl'
require 'json'


# def url_exist?(url_string)

#   puts "Attempting #{url_string}"

#   url = URI.parse(url_string)
#   # p url
#   req = Net::HTTP.new(url.host, url.port)
#   # p req
#   req.use_ssl = (url.scheme == 'https')
#   # p req.use_ssl
#   path = url.path if url.path.empty?
#   # p path
#   res = req.request_head(path || '/')
#   # p res
#   if res.kind_of?(Net::HTTPRedirection)

#     return true # Go after any redirect and make sure you can access the redirected URL

#   else

#     ! %W(4 5).include?(res.code[0]) # Not from 4xx or 5xx families

#   end

# rescue Errno::ENOENT

#   false #false if can't find the server

# rescue URI::InvalidURIError

#   false #false if URI is invalid

# rescue SocketError

#   false #false if Failed to open TCP connection

# rescue Errno::ECONNREFUSED

#   false #false if Failed to open TCP connection

# rescue Net::OpenTimeout

#   false #false if execution expired

# rescue OpenSSL::SSL::SSLError

#   false

# end

# puts url_exist?(url_string)

# url = row['logo_link']

# if url_exist?(url_string)

RESULT = JSON.parse(File.read("#{Rails.root}/lib/scripts/results.json"))
IMAGE_URLS = JSON.parse(File.read("#{Rails.root}/lib/scripts/image_urls.json"))

#

def top5urls(hospital)
  arrayofurlstrings = []
  counter = 0
  # 5.times do
  #   arrayofurlstrings << RESULT[hospital.name]["value"][counter]["contentUrl"]
  #   counter +=1
  # while counter < 5
  # next if RESULT[hospital.name]["value"][counter]["contentUrl"].nil?
  arrayofurlstrings = RESULT[hospital.name]["value"].first(5).map{ |x| x["contentUrl"] }

  # end
  IMAGE_URLS[hospital.name] = arrayofurlstrings
  File.open("#{Rails.root}/lib/scripts/image_urls.json", 'wb') do |file|
    file.write(JSON.generate(IMAGE_URLS))
  end
end

Hospital.all.each do |hospital|
  # next if IMAGE_URLS[hospital.name].present?
  # next if RESULT[hospital.name]["value"][0].nil?
  # next if RESULT[hospital.name]["value"].nil?
  # next if RESULT[hospital.name].nil?
  top5urls(hospital)
end
