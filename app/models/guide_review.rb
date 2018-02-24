class GuideReview < ApplicationRecord
  belongs_to :guide
  belongs_to :review
  belongs_to :traveler
end
