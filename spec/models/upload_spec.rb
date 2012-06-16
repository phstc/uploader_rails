require 'spec_helper'

describe Upload do
  describe 'Attributes validation' do
    context "Empty attributes" do
      let(:empty_upload) { Upload.new }   
      it { empty_upload.should have(1).error_on(:description) }
      it { empty_upload.should have(1).error_on(:file_url) }
    end
  end
end
