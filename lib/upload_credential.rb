require 'digest/md5'
class UploadCredential
  SECRET_KEY = 'BgIPIUgDT1wOwyKQN9Mp'
  
  attr_reader :created_at
  
  def initialize created_at=Time.now
    @created_at = created_at
  end

  def timestamp
    @created_at.to_i
  end

  def security_hash
    @token ||= Digest::MD5.hexdigest SECRET_KEY + self.timestamp.to_s
  end
end
