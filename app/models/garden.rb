class Garden < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  has_many :bookings

  validates :price, :capacity, :address, :description, :owner, :title, presence: true
  validates :address, uniqueness: true

  mount_uploader :photo, PhotoUploader

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
