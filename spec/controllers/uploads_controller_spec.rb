require 'spec_helper'

describe UploadsController do
  describe "GET 'index'" do
    before(:each) { get :index }
    it { should respond_with(:success) }
    it { should assign_to(:uploads) }
  end

  describe "GET 'new'" do
    before(:each) { get :new }
    it { should respond_with(:success) }
    it { should assign_to(:upload) }
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
    let(:upload) { FactoryGirl.create :upload }
    before(:each) { get :show, id: upload.id }
    it { should respond_with(:success) }
    it { should assign_to(:upload).with(upload) }
  end

end
