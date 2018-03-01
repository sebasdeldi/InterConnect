class CreatePieces < ActiveRecord::Migration[5.1]
  def change
    create_table :pieces do |t|
      #t.references :general_cargo_info, foreign_key: true
      t.string :type
      t.decimal :weight
      t.decimal :height
      t.decimal :width
      t.decimal :depth

      t.timestamps
    end
  end
end