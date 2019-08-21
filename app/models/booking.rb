class Booking < ApplicationRecord
  belongs_to :renter, class_name: 'User'
  belongs_to :garden

  STATUSES = %w[available unavailable]

  validates :start_date, :end_date, :price, :status, presence: true
  validates :status, inclusion: { in: STATUSES }
end
