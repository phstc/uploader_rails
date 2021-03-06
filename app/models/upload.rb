class Upload < ActiveRecord::Base  
  validates_presence_of :description
  validates_presence_of :file_url
  
  delegate :timestamp, :security_hash, to: :credential, prefix: true
  
  attr_writer :credential
    
  private
  
  def credential
    @credential ||= UploadCredential.new
  end
end
