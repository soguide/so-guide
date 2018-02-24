class CountryOffering < ApplicationRecord
  belongs_to :guide
  belongs_to :country
end
