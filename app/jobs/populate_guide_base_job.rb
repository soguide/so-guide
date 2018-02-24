require 'csv'
require 'roo'

class PopulateGuideBaseJob < ActiveJob::Base
  def perform(csv)
    parsed_csv = parse_csv(csv)
    p "ITs work !"
  end

  def parse_csv(csv)
    csv_options = { col_sep: ',', headers: :first_row, quote_char: '"' }
    CSV.parse(csv, csv_options) do |row|
      unless row[0].nil?
            id = row[0]
            email = row[1]
            password = row[2]
            first_name = row[3]
            last_name = row[4]
            birth = row[5]
            post = row[6]
            raison = row[7]
            photo = row[8]
            mobile = row[9]
            fixe = row[10]
            state = row[11]
            type = row[12]
            xp = row[13]
            orga = row[14]
            web = row[15]
            license = row[16]
            langue = row[17]
            description = row[18]
            main_review = row[19]
            url = row[20]
            country_first = row[21]
            secondary_email = row[22]
            country_second = row[23]
            facebook_profil_url = row[24]
            facebook_profil_page = row[25]
            gender = row[26]
            langue_second = row[27]
            type_second = row[28]
            langue_third = row[29]
            langue_fourth = row[30]
            langue_fifth = row[31]
            type_third = row[32]
            partners = row[33]

            user = create_user(email, password, first_name, last_name, birth, gender)
            organization = create_organization(orga, url, facebook_profil_url, facebook_profil_page, license)
            contact_info = create_guide_contact_info(mobile, xp, main_review, secondary_email)
            guide = create_guide(id, organization, contact_info, user, photo, description, state)

            #Create countries assosiations
            countries = []
            countries << country_first
            countries << country_second unless country_second.nil?
            create_country_offering(guide, countries)

            #Create speciality assosiations
            specialities = []
            specialities << type
            specialities << type_second unless type_second.nil?
            specialities << type_third unless type_third.nil?
            create_speciality_offering(guide, specialities)

            #Create language assosiations
            languages = []
            languages << langue
            languages << langue_second unless langue_second.nil?
            languages << langue_third unless langue_third.nil?
            languages << langue_fourth unless langue_fourth.nil?
            languages << langue_fifth unless langue_fifth.nil?
            create_spoken_language(guide, languages)
      end
    end
  end

def create_spoken_language(guide, languages)
  languages.each do |l|
    language = Language.find_by(name: l.strip)
    SpokenLanguage.create(
      guide_id: guide.id,
      language_id: language.id
    )
  end
end

def create_speciality_offering(guide, specialities)
  specialities.each do |s|
    speciality = Speciality.find_by(name: s)
    GuideSpeciality.create(
      guide_id: guide.id,
      speciality_id: speciality.id
    )
  end
end

def create_country_offering(guide, countries)
  countries.each do |c|
    country = Country.find_by(name: c)
    CountryOffering.create(
      guide_id: guide.id,
      country_id: country.id
    )
  end
end

def create_guide(id, organization, contact_info, user, photo, description, state)
  guide = Guide.create(
  id: id,
  guide_organization_id: organization.id,
  guide_contact_info_id: contact_info.id,
  user_id: user.id,
  description: description,
  main_photo: photo,
  state: state
  )
  guide
end

def create_guide_contact_info(mobile, xp, main_review, secondary_email)
  contact_info = GuideContactInfo.create(
    mobile_phone: mobile,
    years_experience: xp,
    main_review: main_review,
    secondary_email: secondary_email
    )
  contact_info
end

def create_organization(orga, url, facebook_profil_url, facebook_profil_page, license)
  orga = GuideOrganization.create(
    name: orga,
    structure_website: url,
    facebook_profil_url: facebook_profil_url,
    facebook_structure_url: facebook_profil_page,
    license: license
  )
  orga
end

def create_user(email, password, first_name, last_name, birth, gender)
  user = User.create(
    email: email,
    password: password,
    first_name: first_name,
    last_name: last_name,
    year_of_birth: birth,
    gender: gender
    )
  user
end

end
