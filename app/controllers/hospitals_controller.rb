class HospitalsController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:index, :show]

  before_action :set_hospital, only: :show

  def index
    @hospitals = Hospital.all
    # search bar
    if params[:query].present?
      @hospitals = Hospital.where("name ILIKE ?", "%#{params[:query]}%")
      @markers = @hospitals.map do |hospital|
        {
          lat: hospital.latitude,
          lng: hospital.longitude
        }
      end
    else
      @hospitals = Hospital.all
      @markers = @hospitals.map do |hospital|
        {
          lat: hospital.latitude,
          lng: hospital.longitude
        }
      end
    end
  end

  def show
    # displaying comments
    @comment = Comment.new

    # mapbox
    @marker = {
      lat: @hospital.latitude,
      lng: @hospital.longitude
    }
  end


  private

  def set_hospital
    @hospital = Hospital.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:title, :comment)
  end
end
