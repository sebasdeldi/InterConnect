class CreateCommonStepsInfoRequesteds < ActiveRecord::Migration[5.1]
  def change
    create_table :common_steps_info_requesteds do |t|
      t.boolean :completed, default: false
      t.references :operation, foreign_key: true

      t.timestamps
    end
  end
end
