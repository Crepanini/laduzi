require 'open-uri'
require "net/http"
require 'openssl'


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

url_string = "https://tse2.mm.bing.net/th?id=OIP.RI4TIvq9NlIktsaDlaT-ZAHaE8&pid=Api"
# puts url_exist?(url_string)

# url = row['logo_link']

# if url_exist?(url_string)

download = open(url_string)

IO.copy_stream(download, "#{Rails.root}/app/assets/images/hospital1.jpg")

#   sleep 10

# end
