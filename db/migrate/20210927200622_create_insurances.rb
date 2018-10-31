class CreateInsurances < ActiveRecord::Migration[5.1]
  def change
    create_table :insurances do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
      t.string :modality
      t.string :origin
      t.string :destination
      t.string :incoterm
      t.string :etd
      t.string :carrier
      t.string :commodities
      t.string :marks
      t.float :commercial_value
      t.float :freight
      t.float :duties
      t.float :other_costs
      t.float :voluntary_coverage
      t.float :lost_profit
      t.references :operation, foreign_key: true

      t.timestamps
    end
  end
end
