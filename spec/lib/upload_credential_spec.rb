require 'spec_helper'
require 'digest/md5'
require 'upload_credential'

describe UploadCredential do
  describe 'Credential initialization' do
    context 'with created_at' do
      it 'should set created_at' do
        created_at = Time.now
        credential = UploadCredential.new created_at
        credential.created_at.should eq created_at
      end
    end
    context 'without created_at' do
      it 'should initialize a new created_at' do
        credential = UploadCredential.new
        credential.created_at.should be_an_instance_of(Time)
      end
    end
  end
  describe 'Timestamp' do
    it 'should return the timestamp' do
      created_at = Time.now
      credential = UploadCredential.new created_at
      credential.timestamp.should eq created_at.to_i
    end
  end
  describe 'Credential creation' do
    it 'should generate a security hash' do
      credential = UploadCredential.new Time.now
      Digest::MD5.stub(:hexdigest).with(UploadCredential::SECRET_KEY + credential.timestamp.to_s)
        .and_return('Awesome hash')
      credential.security_hash.should eq 'Awesome hash'
    end
  end
end
