class ChangeAccessTypes < ActiveRecord::Migration[5.2]
  def change
    execute "ALTER TABLE `accessTypes` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ENGINE=InnoDB"
    rename_table :accessTypes, :access_types
    rename_column :access_types, :ID, :id
  end
end
