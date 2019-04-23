class HospitalsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_hospital, only: [:show, :upsave]

  def index
    @insurers = ["CIGNA", "MSH"]
    # "Allianz", "AXA PPP", "AXA ICBC", "AXA Tianping", "BUPA"
    @provider_types = ["Private", "Public", "Dental", "Wellness Checkup"]
    @languages = ["Cn", "Eng", "Canto", "Fr", "Span", "Ru", "Jp", "Kr", "Ger", "Farsi", "Dutch", "Filipino"]
    @specialties = ["Acupuncture", "Cardiology", "Dental", "Dental Care", "Ear, Nose & Throat", "Endocrinology", "Gastroenterology", "General Medicine", "General Surgery", "Gynecology", "Haematology", "Infectious Disease", "Internal Medicine", "Kidney Disease", "Liver Disease", "Neurology", "Nuclear Medicine", "OB & GYN", "Ophthalmology", "Organ Transplants", "Orthopaedics", "Osteology", "Pediatrics", "Physical Checkup", "Pneumology", "Respiratory", "Rheumatology", "Sarcoidosis", "Sport Medicine", "Traditional Chinese Medicine", "TCM physiotherapy", "Tumors", "Urology"]
    @districts = []
    @hospitals = Hospital.all

    unless (params[:tag] != [""] && params["city"].present?)
      location_filter
    end

    if params[:tag] != [""] && params["city"].present?
      location_filter
      @hospitals = @hospitals.tagged_with(params[:tag])
    end


    # @hospitals = @hospitals.tagged_with(params[:tag])
    # elsif !params[:tag] && !params["city"].present?
    #   @hospitals
    # else
    #   location_filter
    #   @hospitals = @hospitals.tagged_with(params[:tag])
    #   # raise

    #district
    @district_hospitals = Hospital.where(city: params["city"])
    @district_hospitals.all.each do |hospital|
      @districts << hospital.district
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
    if user_signed_in?
      @saved = current_user.saved_up_on? @hospital
    else
      @saved = false
    end
    # mapbox
    @marker = {
      lat: @hospital.latitude,
      lng: @hospital.longitude
    }
  end

  # def show
  #   # displaying comments
  #   @comment = Comment.new
  #   @saved = @hospital.saves_for.empty? ? false : @hospital.saves_for.first.save_flag
  #   # mapbox
  #   @marker = {
  #     lat: @hospital.latitude,
  #     lng: @hospital.longitude
  #   }
  # end


  def upsave
    @saved =current_user.saved_up_on? @hospital
    if !@saved
      @hospital.upsaved_by current_user
    else
      @hospital.downsave_from current_user
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

  def taggeddestroy
    @hospital.find(params[:id]).type_list.remove(params[:tag])
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

  def location_filter
    @hospitals = Hospital.where("city ILIKE ?", "%#{params[:city]}%")
  end
end
