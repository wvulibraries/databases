class DbStatus < ActiveRecord::Migration[5.2]
  def change
    execute "ALTER TABLE `dbStatus` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ENGINE=InnoDB"
    execute "ALTER TABLE `dbStatus` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
    rename_table :dbStatus, :database_status
    change_table(:database_status) { |t| t.timestamps }
    rename_column :database_status, :ID, :id
  end
end
