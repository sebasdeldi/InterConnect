class AddDocumentalEmailToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :documental_email, :string
  end
end
