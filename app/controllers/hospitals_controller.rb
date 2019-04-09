class HospitalsController < ApplicationController
  #skip_before_action :authenticate_user!, only: [:index, :show]
  
  def index
    @hospitals = Hospital.all
  end

  def show
    @hospital = Hospital.find(params[:id])
  end
end
