require 'spec_helper'

describe Upload do
  describe 'Attributes validation' do
    context "Empty attributes" do
      subject { Upload.new }   
      it { should validate_presence_of(:description) }
      it { should validate_presence_of(:file_url) }
    end
  end
  
  describe 'UploadCredential' do
    context 'Interface' do
      subject { Upload.new }
      it { should respond_to :credential_security_hash }
      it { should respond_to :credential_timestamp }
    end
  end
end
