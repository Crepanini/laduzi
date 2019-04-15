# comments_controller.rb
class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def show
    set_hospital
    @comments = Comment.all
  end

  def new
    # creating new comment - shown to user only if logged in
    commentable = set_hospital
    @comment = Comment.new
    commentable.comment = @comment
  end

  def create
    set_hospital
    @comment = Comment.new(comment_params)
    @comment.commentable = @hospital
    @comment.user = current_user
    @comment.avg_rating = (@comment.doctor_rating + @comment.service_rating + @comment.environment_rating + @comment.price_rating) / 4
    @comment.save
    redirect_to hospital_path(@hospital)
  end

  private

  def set_hospital
    @hospital = Hospital.find(params[:hospital_id])
  end

  def comment_params
    params.require(:comment).permit(:title, :comment)
  end

end
