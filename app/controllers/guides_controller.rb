class GuidesController < ApplicationController
skip_before_action :authenticate_user!, only: [:show, :index, :upload_guides, :post_upload_guides]
  def show
    @guide = Guide.friendly.find(params[:id])
    @guide_specialities = GuideSpeciality.where(guide: @guide)
    @guide_reviews = GuideReview.where(guide: @guide)
  end

  def upload_guides
  end
  def post_upload_guides
    unless params[:xlsx].nil?
      filepath = params[:xlsx].path
      xlsx = Roo::Spreadsheet.open(filepath)
      xlsx = Roo::Excelx.new(filepath)
      xlsx.default_sheet = xlsx.sheets.first
      csv = xlsx.to_csv
      PopulateGuideBaseJob.perform_later(csv)
      redirect_to upload_guides_path, notice: 'Guide en cours de chargement :)'
    else
      render :upload_guides, error: "Veuillez selectionner un fichier"
    end
  end
end
