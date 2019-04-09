class HospitalsController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:index, :show]

  # skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @hospitals = Hospital.all
  end

  def show

    # displaying commentss
    set_hospital
    @comments =  @hospital.comments

  end



  private

  def set_hospital
    @hospital = Hospital.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:title, :comment, :user)
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
