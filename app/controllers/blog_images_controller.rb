class BlogImagesController < ApplicationController
  skip_before_filter :authenticate_user!

  def create
    owner = JSON.parse(params[:hint]).symbolize_keys
    @asset = BlogImage.new(image: params[:file],
                            owner_type: owner[:type], owner_id: owner[:id])
    if @asset.save!
      render json: {
          image: {
              url: @asset.image.url
          }
      }, content_type: "text/html"
    end
  end
end
