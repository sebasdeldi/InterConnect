class CreateInvoices < ActiveRecord::Migration[5.1]
  def change
    create_table :invoices do |t|
    	t.references :operation, foreign_key: true
    	t.json :files
    	t.boolean :requested, default: false
    	t.timestamps
      t.timestamps
    end
  end
end
