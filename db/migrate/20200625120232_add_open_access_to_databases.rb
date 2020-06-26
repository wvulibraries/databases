class AddOpenAccessToDatabases < ActiveRecord::Migration[5.2]
  def change
    add_column :database_list, :open_access, :boolean, default: false
  end
end
