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

def url_exist?(url_string)
  puts "Attempting #{url_string}"
  url = URI.parse(url_string)
  req = Net::HTTP.new(url.host, url.port)
  req.use_ssl = (url.scheme == 'https')
  path = url.path if url.path.present?
  res = req.request_head(path || '/')

  if res.kind_of?(Net::HTTPRedirection)
    return true # Go after any redirect and make sure you can access the redirected URL
  else
    ! %W(4 5).include?(res.code[0]) # Not from 4xx or 5xx families
  end

rescue
rescue Errno::ENOENT
  false #false if can't find the server
rescue URI::InvalidURIError
  false #false if URI is invalid
rescue SocketError
  false #false if Failed to open TCP connection
rescue Errno::ECONNREFUSED
  false #false if Failed to open TCP connection
rescue Net::OpenTimeout
  false #false if execution expired
rescue OpenSSL::SSL::SSLError
  false
rescue Errno::ECONNRESET
  false
rescue Net::ReadTimeout
  false
rescue EOFError
  false
rescue RuntimeErrors
  false
end

def download_item(url, key, i)
  if url_exist?(url)
    download = open(url)
    IO.copy_stream(download, "#{Rails.root}/app/assets/images/hospitals_0424/#{key}_#{i}.jpg")
  end
rescue
end


IMAGE_URLS.each do |key, value|
  next if key.include?("/")
  value.each_with_index do |url, i|
    download_item(url, key, i)
  end
end

# Dir.foreach('app/assets/images/hospitals_0424') do |file|
#   unless file == '.' or file == '..'
#     hospital_name = file.split('_')[0]
#     p hospital_name
#     hospital = Hospital.find_by(name: hospital_name)
#     puts hospital.name.parameterize.underscore

#     Cloudinary::Uploader.upload("#{Rails.root}/app/assets/images/hospitals/#{file}", public_id: "#{hospital.name.parameterize.underscore}")
#     # return cl_image_tag(hospital.id.to_s + ".jpg")
#   end
# end



# Dir.foreach('app/assets/images/hangzhouhospitals') do |file|
#   unless file == '.' or file == '..'
#     hospital_name = file.split('_')[0]
#     p hospital_name
#     hospital = Hospital.find_by(name: hospital_name)
#     puts hospital.name.parameterize.underscore

#     Cloudinary::Uploader.upload("#{Rails.root}/app/assets/images/hospitals/#{file}", public_id: "#{hospital.name.parameterize.underscore}")
#     # return cl_image_tag(hospital.id.to_s + ".jpg")
#   end
# end

# Dir.foreach('app/assets/images/hangzhouhospitals') do |file|
#   unless file == '.' or file == '..'
#     hospital_name = file.split('_')[0]
#     p hospital_name
#     hospital = Hospital.find_by(name: hospital_name)
#     puts hospital.name.parameterize.underscore

#     Cloudinary::Uploader.upload("#{Rails.root}/app/assets/images/hangzhouhospitals/#{file}", public_id: "#{hospital.name.parameterize.underscore}")
#     # return cl_image_tag(hospital.id.to_s + ".jpg")
#   end
# end
