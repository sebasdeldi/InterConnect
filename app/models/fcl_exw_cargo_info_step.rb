class FclExwCargoInfoStep < ApplicationRecord
	strip_attributes
  belongs_to :operation
  has_many :tasks
  has_many :pieces, dependent: :destroy
	accepts_nested_attributes_for :pieces, allow_destroy: true
  mount_uploaders :files, FileUploader

  def filename
    File.basename(path)
  end
end
