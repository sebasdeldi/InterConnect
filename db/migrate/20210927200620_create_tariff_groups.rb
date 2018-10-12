class CreateTariffGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :tariff_groups do |t|
      t.references :sli, foreign_key: true

      t.string :schedule_b
      t.string :code
      t.integer :units
      t.float :value
      t.float :weight
      t.string :eccn

      t.timestamps
    end
  end
end
