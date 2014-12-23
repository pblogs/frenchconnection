class BlogImagesController < ApplicationController
  skip_before_filter :authenticate_user!

  def create
    @asset = BlogImage.new(image: params[:file], description: params[:alt])
    if @asset.save!
      render json: {
          image: {
              url: @asset.image.url
          }
      }, content_type: "text/html"
    end
  end
end
