class HospitalsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_hospital, only: [:show, :upsave]

  def index
    @insurers = ["Allianz", "AXA PPP", "AXA ICBC", "AXA Tianping", "BUPA", "CIGNA", "Discovery Health", "Generali", "MSH", "NOW Health"]
    @provider_types = ["Private", "Public", "Dental", "Wellness Checkup"]
    @languages = ["Cn", "Eng", "Canto", "Fr", "Span", "Ru", "Jp", "Kr", "Ger", "Farsi", "Dutch", "Filipino"]
    @specialties = ["Acupuncture", "Cardiology", "Dental", "Dental Care", "Ear, Nose & Throat", "Endocrinology", "Gastroenterology", "General Medicine", "General Surgery", "Gynecology", "Haematology", "Infectious Disease", "Internal Medicine", "Kidney Disease", "Liver Disease", "Neurology", "Nuclear Medicine", "OB & GYN", "Ophthalmology", "Organ Transplants", "Orthopaedics", "Osteology", "Pediatrics", "Physical Checkup", "Pneumology", "Respiratory", "Rheumatology", "Sarcoidosis", "Sport Medicine", "Traditional Chinese Medicine", "TCM physiotherapy", "Tumors", "Urology"]


    @hospitals = Hospital.all

    if params.key?("tag") and !params[:tag].empty?
      @hospitals = @hospitals.tagged_with(params[:tag])
      location_filter
    else
      location_filter
    end

    # search bar
    if params[:query].present?
      return @hospitals = Hospital.where("name @@ ?", "%#{params[:query]}%")
    end

    set_markers

  end

  def show
    # displaying comments
    @comment = Comment.new
    @saved = @hospital.saves_for.empty? ? false : @hospital.saves_for.first.save_flag
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

  # def specialty_list
  #   temp = []
  #   @hospitals = Hospital.all
  #   @hospitals.each do |hospital|
  #     hospital.specialty.split(", ").each do |specialty|
  #       temp << specialty
  #     end
  #   end
  #   print @specialties = temp.uniq.sort
  # end

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

  def location_filter
    @hospitals = Hospital.where("city ILIKE ?", "%#{params[:city]}%")
  end
end
