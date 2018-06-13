class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :note
      t.string :status, default: 'PENDING'
      t.date :due_date
      t.references :operation, foreign_key: true

      t.timestamps
    end
  end
end
