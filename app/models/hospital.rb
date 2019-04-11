class Hospital < ApplicationRecord
  has_many :reviews
  has_many :appointments

  validates :image, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
  validates :address, presence: true, uniqueness: true
  validates :price, presence: true
  validates :open_at, presence: true
  validates :close_at, presence: true
  validates :longitude, presence: true, uniqueness: true
  validates :latitude, presence: true, uniqueness: true
  validates :tel, presence: true, uniqueness: true

  acts_as_commentable

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
