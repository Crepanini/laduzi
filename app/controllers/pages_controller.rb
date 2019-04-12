class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  def home

  end

  private

  def hospital_params
    params.require(:hospital).permit(:tag)
  end

end
