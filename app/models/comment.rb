class Comment < ActiveRecord::Base

  acts_as_commentable

  belongs_to :commentable, :polymorphic => true

  # NOTE: Comments belong to a user
  belongs_to :user

end
