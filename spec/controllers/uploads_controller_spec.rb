require 'spec_helper'

describe UploadsController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "POST 'create'" do
    it "returns http success" do
      post :create, upload: FactoryGirl.attributes_for(:upload)
      response.should redirect_to(upload_path(Upload.last))     
    end
    
    it "should create a new upload" do
      expect {
         post :create, upload: FactoryGirl.attributes_for(:upload)
       }.to change(Upload, :count).by(1)       
    end
    
    it "should redirect to new" do
      post :create, upload: {}
      response.should render_template(:new)
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      upload = FactoryGirl.create :upload
      get 'show', id: upload.id
      response.should be_success
    end
  end

end
