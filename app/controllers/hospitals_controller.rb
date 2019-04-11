class HospitalsController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_hospital, only: :show

  def index

    if params[:tag].present?
      @hospitals = Hospital.tagged_with(params[:tag])
    else
      @hospitals = Hospital.all
    end
    @insurers = ["Allianz", "AXA PPP", "AXA ICBC", "AXA Tianping", "BUPA", "CIGNA", "Discovery Health", "Generali", "MSH", "NOW Health"]
    @provider_types = ["private", "public"]
    @languages = ["chinese", "english", "cantonese", "french", "spanish", "russian"]
    @specialties = ["family medicine", "pediatrics", "cardiology", "dermatology"]

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
