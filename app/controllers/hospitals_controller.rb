class HospitalsController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:index, :show]

  def index
  end

  def show

    # creating new comment - shown to user only if logged in
    @hospital = Hospital.find(params[:id])
    @comment = Comment.new
    @hospital.comment = @comment
    @comment.title = "Take input from user"
    @comment.comment = "Take input from user"
    @comment.save

    # displaying comments
    @comments = Comment.all
  end
end
