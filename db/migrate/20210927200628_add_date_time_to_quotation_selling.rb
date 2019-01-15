class AddDateTimeToQuotationSelling < ActiveRecord::Migration[5.1]
  def change
  	add_column :fcl_exw_steps_quotation_sellings, :created_at, :datetime
  	add_column :fcl_exw_steps_quotation_sellings, :updated_at, :datetime
  end
end
