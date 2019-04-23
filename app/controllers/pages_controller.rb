class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  def home
    @hospitals = Hospital.all

    if params.key?("tag") && !params[:tag].empty?
      raise
      @hospitals = @hospitals.tagged_with(params[:tag])
    else
      location_filter
    end
  end

  def dashboard
    @saves = current_user.get_up_saved Hospital
  end

  private

  def hospital_params
    params.require(:hospital).permit(:tag, :city, :query)
  end

  def location_filter
    @hospitals = Hospital.where("city ILIKE ?", "%#{params[:city]}%")
  end

end
