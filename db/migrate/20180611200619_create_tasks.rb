class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :note
      t.string :status
      t.date :due_date
      t.references :operations_by_user, foreign_key: true

      t.timestamps
    end
  end
end
