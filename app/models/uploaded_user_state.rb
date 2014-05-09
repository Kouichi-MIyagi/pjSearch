class UploadedUserState < ActiveRecord::Base
  attr_accessible :comment, :csvfile
  mount_uploader :csvfile, CsvfileUploader

  def csvfilePath
#	res = URI.decode(self.csvfile.to_s)
	return URI.decode(self.csvfile.to_s).sub("#{Rails.root}/",'')	
  end
end
