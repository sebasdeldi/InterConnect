class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.integer :team_leader

      t.timestamps
    end
  end
end
