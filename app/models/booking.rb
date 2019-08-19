class Booking < ApplicationRecord
  belongs_to :renter, class_name: 'User'
  belongs_to :garden

  STATUSES = %w[available unavailable]

  validates :renter, :garden, :price, :status, presence: true
  validates :status, inclusion: { in: STATUSES }
end
