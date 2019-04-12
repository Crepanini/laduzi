class HospitalsController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_hospital, only: :show

  def index
    @insurers = ["Allianz", "AXA PPP", "AXA ICBC", "AXA Tianping", "BUPA", "CIGNA", "Discovery Health", "Generali", "MSH", "NOW Health"]
    @provider_types = ["Private", "Public"]
    @languages = ["Chinese", "English", "Cantonese", "French", "Spanish", "Russian"]
    @specialties = ["Family Medicine", "Pediatrics", "Cardiology", "Dermatology"]

    if params[:tag].present?
      return @hospitals = Hospital.tagged_with(params[:tag])
    else
      return @hospitals = Hospital.all
    end


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
end
