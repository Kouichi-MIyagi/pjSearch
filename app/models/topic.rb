class Topic < ActiveRecord::Base
  mount_uploader :picture, PictureUploader

end
