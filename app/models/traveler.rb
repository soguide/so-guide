class Traveler < ApplicationRecord
  belongs_to :user
  has_many :guide_reviews
  extend FriendlyId
  friendly_id :full_name, use: :slugged


  def full_name
    self.user.first_name + ' ' + self.user.last_name
  end
end
