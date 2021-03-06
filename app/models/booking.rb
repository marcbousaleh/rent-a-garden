class Booking < ApplicationRecord
  belongs_to :renter, class_name: 'User'
  belongs_to :garden

  STATUSES = %w[available unavailable]

  validates :renter, :garden, :start_date, :end_date, :price, presence: true
  validates :status, inclusion: { in: STATUSES }
end
