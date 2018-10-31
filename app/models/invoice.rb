class Invoice < ApplicationRecord
	strip_attributes
  belongs_to :operation

  mount_uploaders :files, FileUploader

  def filename
    File.basename(path)
  end
end
