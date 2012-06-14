class Upload < ActiveRecord::Base
  validates_presence_of :description
  validates_presence_of :file_url
end
