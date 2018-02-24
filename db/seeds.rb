require 'csv'
require 'roo'


def get_countries
    arr = []
    csv_text = File.read('BDD-COUNTRY.tsv')
    csv = CSV.parse(csv_text, :headers => false, :col_sep => "\t") do |row|
      Country.create(
        name: row[0],
        description: row[1],
        best_period: row[2]
        )
      CountryPhoto.create(
        main: row[3],
        second: row[4],
        third: row[5],
        fourth: row[6],
        country_id: Country.last.id
        )
    end
end

def get_specialities
  ["Guide culturel", "Guide de trek", "Chauffeur"].each do |spe|
    Speciality.create(
      name: spe
    )
  end
end

def get_languages
[ "Francais",
  "Anglais",
  "Espagnol",
  "Hollandais",
  "Portugais",
  "Allemand",
  "Italien",
  "Hindi",
  "Chinois",
  "Japonais",
  "Thailandais",
  "Russe"
  ].each do |langue|
    Language.create(
    name: langue
    )
  end
end

get_languages
get_specialities
get_countries


AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
