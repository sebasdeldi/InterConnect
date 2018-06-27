class CreateFclExwInfoConfirmedSteps < ActiveRecord::Migration[5.1]
  def change
    create_table :fcl_exw_info_confirmed_steps do |t|
      t.boolean :completed, default: false
      t.references :operation, foreign_key: true

      t.timestamps
    end
  end
end
