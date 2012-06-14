class UploadsController < ApplicationController
  def index
    @uploads = Upload.all
  end

  def new
    @upload = Upload.new
  end

  def create
    @upload = Upload.new(params[:upload])
    if @upload.save
      redirect_to upload_path(@upload)
    else
      render :new
    end
  end

  def show
    @upload = Upload.find(params[:id])
  end
end
