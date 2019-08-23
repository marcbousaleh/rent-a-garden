class Review < ApplicationRecord
  belongs_to :garden
  validates :content, length: { minimum: 20 }
end
