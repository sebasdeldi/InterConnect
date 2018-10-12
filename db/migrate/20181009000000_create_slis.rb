class CreateSlis < ActiveRecord::Migration[5.1]
  def change
    create_table :slis do |t|
      t.references :operation, foreign_key: true
      t.json :files
      t.timestamps
    end
  end
end
