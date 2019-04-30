class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  def home
    @hospitals = Hospital.all
  end

  def dashboard
    @saves = current_user.get_up_saved Hospital
  end

  private

  def hospital_params
    params.require(:hospital).permit(:tag, :city, :query)
  end

end
