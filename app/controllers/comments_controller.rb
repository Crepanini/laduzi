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

# create_table "comments", id: :serial, force: :cascade do |t|
#     t.string "title", limit: 50, default: ""
#     t.text "comment"
#     t.string "commentable_type"
#     t.integer "commentable_id"
#     t.integer "user_id"
#     t.datetime "created_at"
#     t.datetime "updated_at"
#     t.index ["commentable_id"], name: "index_comments_on_commentable_id"
#     t.index ["commentable_type"], name: "index_comments_on_commentable_type"
#     t.index ["user_id"], name: "index_comments_on_user_id"
#   end
