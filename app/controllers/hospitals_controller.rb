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
  end

  def show
    # displaying comments
    @comment = Comment.new
  end

  private

  def set_hospital
    @hospital = Hospital.find(params[:id])
  end


end
