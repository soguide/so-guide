ActiveAdmin.register Guide do
  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end
end
