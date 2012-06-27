require 'spec_helper'

describe Upload do
  describe 'Attributes validation' do
    context "Empty attributes" do
      subject { Upload.new }   
      it { should have(1).error_on(:description) }
      it { should have(1).error_on(:file_url) }
    end
  end
  
  describe 'UploadCredential' do
    context 'Delegation' do
      subject { Upload.new }
      it { should respond_to :credential_security_hash }
      it { should respond_to :credential_timestamp }
    end
  end
end
