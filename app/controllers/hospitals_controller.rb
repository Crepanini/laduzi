class HospitalsController < ApplicationController

  # skip_before_action :authenticate_user!, only: [:index, :show]

  before_action :set_hospital, only: :show

  def index
    @hospitals = Hospital.all
  end

  def show
    # displaying comments
    @comment = Comment.new
  end


  private

  def set_hospital
    @hospital = Hospital.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:title, :comment)
  end
end
