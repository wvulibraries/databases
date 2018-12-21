class AddAccessToDatabases < ActiveRecord::Migration[5.2]
  def change
    add_column :database_list, :access, :integer
  end
end
