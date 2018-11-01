class IpLocations < ActiveRecord::Migration[5.2]
  def change
    execute "ALTER TABLE `ipLocations` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ENGINE=InnoDB"
    execute "ALTER TABLE `ipLocations` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
    rename_table :ipLocations, :ip_locations
    change_table(:ip_locations) { |t| t.timestamps }
    rename_column :ip_locations, :ID, :id
    rename_column :ip_locations, :ipRange, :ip_range
  end
end
