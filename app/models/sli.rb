class Sli < ApplicationRecord
	strip_attributes
  belongs_to :operation
  has_many :tariff_groups, dependent: :destroy
  accepts_nested_attributes_for :tariff_groups, :allow_destroy => true

  mount_uploaders :files, FileUploader

  def filename
    File.basename(path)
  end

  def self.create_tariff_groups (params_array, sli)
    sli.update(requested: true)
    TariffGroup.where(sli_id: sli.id).delete_all
    (0..params_array.length).step(6) do |element|
      unless params_array[element].nil?
        tariff_group = TariffGroup.create!(sli_id: sli.id, code: params_array[element][1], schedule_b: params_array[element+1][1], units: params_array[element+2][1], weight:params_array[element+3][1], value: params_array[element+4][1], eccn: params_array[element+5][1] )
      end
    end
  end
end
