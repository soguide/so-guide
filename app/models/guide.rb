class Guide < ApplicationRecord
  belongs_to :guide_organization, optional: true
  belongs_to :guide_contact_info, optional: true
  belongs_to :user
  has_one  :country_offering, dependent: :destroy
  has_many  :guide_specialities, dependent: :destroy
  has_many  :guide_reviews, dependent: :destroy
  has_many  :spoken_languages, dependent: :destroy
  extend FriendlyId
  friendly_id :full_name, use: :slugged


  def full_name
    unless self.user.nil?
    self.user.first_name + ' ' + self.user.last_name
    end
  end

end
