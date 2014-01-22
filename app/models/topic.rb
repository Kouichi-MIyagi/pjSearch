class Topic < ActiveRecord::Base
  mount_uploader :picture, PictureUploader
  attr_accessible :contents, :effective_to, :title, :picture

end
