class Country < ApplicationRecord
  has_one :country_photo, dependent: :destroy
  extend FriendlyId
  friendly_id :name, use: :slugged
end
