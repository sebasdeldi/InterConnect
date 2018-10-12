class Sli < ApplicationRecord
	strip_attributes
  belongs_to :operation
  has_many :tariff_groups, dependent: :destroy
  accepts_nested_attributes_for :tariff_groups, :allow_destroy => true

  mount_uploaders :files, FileUploader

  def filename
    File.basename(path)
  end
end
