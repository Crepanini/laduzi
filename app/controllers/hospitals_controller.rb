class HospitalsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_hospital, only: [:show, :upsave]

  def index
    @insurers = ["Allianz", "AXA PPP", "AXA ICBC", "AXA Tianping", "BUPA", "CIGNA", "Discovery Health", "Generali", "MSH", "NOW Health"]
    @provider_types = ["Private", "Public"]
    @languages = ["Chinese", "English", "Cantonese", "French", "Spanish", "Russian"]
    @specialties = ["Family Medicine", "Pediatrics", "Cardiology", "Dermatology", "Gastroenterology", "General Surgery", "Anaesthesiology", "Radiology", "Pathology", "Plastic Surgery", "Psychiatry", "Respiratory Medicine", "Urology", "Dentistry", "Chinese Medicine"]

    @hospitals = Hospital.all

    if params[:tag].present?
      @hospitals = Hospital.tagged_with(params[:tag])
    end

    # search bar
    if params[:query].present?
      return @hospitals = Hospital.where("name ILIKE ?", "%#{params[:query]}%")
    end

    set_markers
  end

  def show
    # displaying comments
    @comment = Comment.new
    @saved = @hospital.saves_for.first.save_flag
    # mapbox
    @marker = {
      lat: @hospital.latitude,
      lng: @hospital.longitude
    }
  end

  def upsave
    @saved = @hospital.saves_for
    if @saved.empty?
      @hospital.upsaved_by current_user
    else
      if @saved.first.save_flag
        @hospital.downsave_from current_user
      else
        @hospital.upsaved_by current_user
      end
    end
    redirect_to hospital_path(@hospital)
  end

  def downsave
    @hospital.downsave_from current_user
    redirect_to hospital_path(@hospital)
  end

  private

  def set_hospital
    @hospital = Hospital.find((params[:id] || params[:hospital_id]))
  end

  def set_markers
    @markers = @hospitals.map do |hospital|
      {
        lat: hospital.latitude,
        lng: hospital.longitude
      }
    end
  end
end
