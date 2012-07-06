require 'spec_helper'

describe Upload do
  describe 'Attributes validation' do
    context "Empty attributes" do
      it { should validate_presence_of(:description) }
      it { should validate_presence_of(:file_url) }
    end
  end
  
  describe 'UploadCredential' do
    context 'Responding to the interface' do
      it { should respond_to :credential_security_hash }
      it { should respond_to :credential_timestamp }
    end
    
    context 'Setting a credential' do
      it 'should set and delegate to a credential' do
        credential = mock
        credential.should_receive(:security_hash).and_return 'abcd'
        credential.should_receive(:timestamp).and_return 1234
        subject.credential = credential
        subject.credential_security_hash.should eq 'abcd'
        subject.credential_timestamp.should eq 1234
      end
    end
    
    context 'Default credential' do
      it 'should use UploadCredential as default' do
        UploadCredential.any_instance.should_receive(:security_hash).and_return 'abcd'
        UploadCredential.any_instance.should_receive(:timestamp).and_return 1234
        subject.credential_security_hash.should eq 'abcd'
        subject.credential_timestamp.should eq 12345
      end
    end
  end
end
