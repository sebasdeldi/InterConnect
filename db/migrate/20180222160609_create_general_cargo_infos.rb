class CreateGeneralCargoInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :general_cargo_infos do |t|
      t.references :operation, foreign_key: true
      t.timestamps
    end
  end
end
