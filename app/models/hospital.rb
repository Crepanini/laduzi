class Hospital < ApplicationRecord
  has_many :reviews
  has_many :appointments

  # validates :image
  # validates :name, presence: true, uniqueness: true
  # validates :address, presence: true, uniqueness: true
  # validates :open_at, presence: true
  # validates :close_at, presence: true
  # validates :longitude, presence: true
  # validates :latitude, presence: true
  # validates :tel, presence: true, uniqueness: true

  acts_as_commentable
  acts_as_taggable_on :tags

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  acts_as_saveable
end
