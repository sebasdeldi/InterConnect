class CreateFunctionalities < ActiveRecord::Migration[5.1]
  def change
    create_table :functionalities do |t|
    	t.belongs_to :role, index: true, foreign_key: true
      t.timestamps
    end
  end
end
