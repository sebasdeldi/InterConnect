class AddDateTimeToQuotationSelling < ActiveRecord::Migration[5.1]
  def change
  	add_column :fcl_exw_quotation_selling_steps, :created_at, :datetime
  	add_column :fcl_exw_quotation_selling_steps, :updated_at, :datetime
  end
end
