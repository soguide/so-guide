class SpokenLanguage < ApplicationRecord
  belongs_to :language
  belongs_to :guide
end
