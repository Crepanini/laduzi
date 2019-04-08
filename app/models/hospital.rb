class Hospital < ApplicationRecord
  has_many :reviews
  has_many :appointments

  validates :image, presence: true
  validates :name, presence: true, uniqueness: true
  validates :address, presence: true, uniqueness: true
  validates :price, presence: true
  validates :open_at, presence: true
  validates :close_at, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true
end

