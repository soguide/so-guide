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

            if User.find_by(:xlsx_id => id).nil?
                create_row_on_db(id, email, password, first_name, last_name, birth, gender, orga, url, facebook_profil_url, facebook_profil_page, license,
                  mobile, xp, main_review, secondary_email, photo, description, state, country_first, country_second, langue, langue_second, langue_third,
                  langue_fourth, langue_fifth, type, type_second, type_third)
              else
                existing_user = User.find(id)
                update_all_db(existing_user, email, password, first_name, last_name, birth, gender, orga, url, facebook_profil_url, facebook_profil_page, license,
                  mobile, xp, main_review, secondary_email, photo, description, state, country_first, country_second, langue, langue_second, langue_third,
                  langue_fourth, langue_fifth, type, type_second, type_third)
              end
      end
    end
  end

def update_all_db(existing_user, email, password, first_name, last_name, birth, gender, orga, url, facebook_profil_url, facebook_profil_page, license,
                  mobile, xp, main_review, secondary_email, photo, description, state, country_first, country_second, langue, langue_second, langue_third,
                  langue_fourth, langue_fifth, type, type_second, type_third)
  update_user(existing_user)
  guide = update_guide(existing_user)
  #Set language array
  languages = []
  languages << langue
  languages << langue_second unless langue_second.nil?
  languages << langue_third unless langue_third.nil?
  languages << langue_fourth unless langue_fourth.nil?
  languages << langue_fifth unless langue_fifth.nil?
  update_spoken_language(guide, languages)

  #Set speciality array
  specialities = []
  specialities << type
  specialities << type_second unless type_second.nil?
  specialities << type_third unless type_third.nil?
  update_speciality_offering(guide, specialities)

  #set countries array
  countries = []
  countries << country_first
  countries << country_second unless country_second.nil?
  update_country_offering(guide, countries)

end

def update_country_offering(guide, countries)
  countries.each do |c|
    country = Country.find_by(name: c)
    country_offering = CountryOffering.where(guide_id: guide.id, country_id: country.id).first
    unless country_offering.nil?
      country_offering.update(
        guide_id: guide.id,
        country_id: country.id
      )
    end
  end
end


def update_speciality_offering(guide, specialities)
  specialities.each do |s|
    speciality = Speciality.find_by(name: s)
    guide_specialitie = GuideSpeciality.where(guide_id: guide.id, speciality_id: speciality.id).first
    unless guide_specialitie.nil?
      guide_specialitie.update!(
        guide_id: guide.id,
        speciality_id: speciality.id
      )
    end
  end
end

def update_spoken_language(guide, languages)
  languages.each do |l|
    language = Language.find_by(name: l.strip)
    spoken_language = SpokenLanguage.where(guide_id: guide.id, language_id: language.id).first
    unless spoken_language.nil?
        spoken_language.update!(
          guide_id: guide.id,
          language_id: language.id
        )
    end
  end
end

def update_guide(existing_user)
  guide = existing_user.guide
  guide.update!(
  guide_organization_id: guide.guide_organization_id,
  guide_contact_info_id: guide.guide_contact_info_id,
  user_id: existing_user.id,
  description: guide.description,
  main_photo: guide.main_photo,
  state: guide.state
  )
  guide
end


def update_user(existing_user)
    existing_user.update!(
    email: existing_user.email,
    password: existing_user.password,
    first_name: existing_user.first_name,
    last_name: existing_user.last_name,
    year_of_birth: existing_user.year_of_birth,
    gender: existing_user.gender
    )
end

def create_row_on_db(id, email, password, first_name, last_name, birth, gender, orga, url, facebook_profil_url, facebook_profil_page, license,
              mobile, xp, main_review, secondary_email, photo, description, state, country_first, country_second, langue, langue_second, langue_third,
              langue_fourth, langue_fifth, type, type_second, type_third)

  user = create_user(id, email, password, first_name, last_name, birth, gender)
  organization = create_organization(orga, url, facebook_profil_url, facebook_profil_page, license)
  contact_info = create_guide_contact_info(mobile, xp, main_review, secondary_email)
  guide = create_guide(organization, contact_info, user, photo, description, state)

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

def create_guide(organization, contact_info, user, photo, description, state)
  guide = Guide.create(
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

def create_user(id, email, password, first_name, last_name, birth, gender)
  user = User.create(
    email: email,
    password: password,
    first_name: first_name,
    last_name: last_name,
    year_of_birth: birth,
    gender: gender,
    xlsx_id: id
    )
  user
end

end
