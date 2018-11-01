class DbStats < ActiveRecord::Migration[5.2]
  def change
    execute "ALTER TABLE `dbStats` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ENGINE=InnoDB"
    execute "ALTER TABLE `dbStats` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
    rename_table :dbStats, :statistics
    change_table(:statistics) { |t| t.timestamps }
    rename_column :statistics, :ID, :id
    rename_column :statistics, :location, :location
    rename_column :statistics, :accessDate, :access_date
    rename_column :statistics, :referrer, :referrer
    rename_column :statistics, :ipaddress, :ip_address
  end
end
