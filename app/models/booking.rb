class Booking < ApplicationRecord
  belongs_to :traveler
  belongs_to :guide
end
