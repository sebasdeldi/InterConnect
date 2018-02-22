class CreateSteps < ActiveRecord::Migration[5.1]
  def change
    create_table :steps do |t|
      t.references :operation, foreign_key: true
      t.timestamps
    end
  end
end
