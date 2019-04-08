class Hospital < ApplicationRecord
  has_many :reviews
  has_many :appointments
end
