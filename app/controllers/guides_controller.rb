class GuidesController < ApplicationController
skip_before_action :authenticate_user!, only: [:show, :index, :upload_guides, :post_upload_guides]
  def show
    @guide = Guide.friendly.find(params[:id])
    @guide_specialities = GuideSpeciality.where(guide: @guide)
    country = @guide.country_offering.country.name
    @other_guide = CountryOffering.where(country: country)
    @guide_reviews = GuideReview.where(guide: @guide)
  end

  def upload_guides
  end
  def post_upload_guides
    filepath = params[:xlsx].path
    xlsx = Roo::Spreadsheet.open(filepath)
    xlsx = Roo::Excelx.new(filepath)
    xlsx.default_sheet = xlsx.sheets.first
    csv = xlsx.to_csv
    PopulateGuideBaseJob.perform_later(csv)
    redirect_to upload_guides_path, notice: 'Guide en cours de chargement :)'
  end
end
