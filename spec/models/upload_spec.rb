require 'spec_helper'

describe Upload do
  describe 'Attributes validation' do
    context "Empty attributes" do
      let(:empty_upload) { Upload.new }   
      it { empty_upload.should have(1).error_on(:description) }
      it { empty_upload.should have(1).error_on(:file_url) }
    end
  end
  
  describe 'Credential' do
    context 'Delegation' do
      it 'should respond_to UploadCredential attributes' do
        upload = Upload.new
        upload.respond_to?(:credential_security_hash).should be_true
        upload.respond_to?(:credential_timestamp).should be_true
      end
    end
  end
end
