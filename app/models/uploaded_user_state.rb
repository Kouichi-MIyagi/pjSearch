class UploadedUserState < ActiveRecord::Base
  mount_uploader :csvfile, CsvfileUploader

  def csvfilePath
#	res = URI.decode(self.csvfile.to_s)
	return URI.decode(self.csvfile.to_s).sub("#{Rails.root}/",'')	
  end
end
