class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    user = User.find_for_facebook_oauth(request.env['omniauth.auth'])

    if user.persisted?
      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
      sign_in_and_redirect user, event: :authentication
    else
      session['devise.facebook_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

  def google_oauth2
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in_and_redirect @user, event: :authentication
    else
      session['devise.google_data'] = request.env['omniauth.auth'].except(:extra) # Removing extra as it can overflow some session stores
      redirect_to hospitals_index_path, alert: @user.errors.full_messages.join("\n")
    end
  end
end



  # def self.from_omniauth(access_token)
  #   data = access_token.info
  #   user = User.where(email: data['email']).first
  #   # Uncomment the section below if you want users to be created if they don't exist
  #   unless user
  #     user = User.create(name: data['name'],
  #     email: data['email'],
  #     password: Devise.friendly_token[0, 20]
  #     )
  #   end
  #   user
  # end
# Devise::OmniauthCallbacksController
#   def google_oauth2
#     p "google auth begins"
#     @user = User.from_omniauth(request.env["omniauth.auth"])
# if @user.persisted?
#   p "google user persisted"
#       sign_in @user, :event => :authentication #this will throw if @user is not activated
#       set_flash_message(:notice, :success, :kind => "Google") if is_navigational_format?
#     else
#       session["devise.google_data"] = request.env["omniauth.auth"]
#     end
#     redirect_to hospitals_index_path
#   end
