class CountriesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index]
  def index
    @countries = Country.all
  end
  def show
    @country = Country.friendly.find(params[:name])
    @guides = CountryOffering.where(country_id: @country)
  end
end
