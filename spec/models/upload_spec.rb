require 'spec_helper'

describe Upload do
  describe 'Validations' do
    # http://blog.davidchelimsky.net/2012/05/13/spec-smell-explicit-use-of-subject/
    # it { should validates_presence_of(:description) }
    # it { should validates_presence_of(:file_url) }
    it "should validate presence of description" do
      upload = Upload.new
      upload.should have(1).error_on(:description)
    end
    
    it "should validate presence of file_url" do
      upload = Upload.new
      upload.should have(1).error_on(:file_url)
    end
  end
end
