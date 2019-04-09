# comments_controller.rb
class CommentsController < ApplicationController

  def new
    # creating new comment - shown to user only if logged in
    commentable = set_hospital
    @comment = Comment.new
    commentable.comment = @comment
  end

  def create
    @comment.save
    # @comment = commentable.comments.new

    # @hospital.comment = @comment
    # @comment.save
  end

  private

  def set_hospital
    @hospital = Hospital.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:title, :comment, :user)
  end

end
