# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET']
#    {
#       scope: 'userinfo.email, userinfo.profile, http://gdata.youtube.com',
#       prompt: 'select_account',
#       image_aspect_ratio: 'square',
#       image_size: 50
#     }
# end

# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :facebook, ENV['FB_ID'], ENV['FB_SECRET']
# end
