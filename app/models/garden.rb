class Garden < ApplicationRecord
  belongs_to :owner, class_name: 'User'

  has_many :reviews, dependent: :destroy
  has_many :bookings, dependent: :destroy

  validates :price, :capacity, :address, :description, :owner, :title, presence: true
  validates :address, uniqueness: true

  mount_uploader :photo, PhotoUploader

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  include PgSearch::Model
  pg_search_scope :search_by_address_and_title,
                  against: [:address, :title],
                  using: {
                    tsearch: { prefix: true }
                  }
end
