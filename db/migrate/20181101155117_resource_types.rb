class ResourceTypes < ActiveRecord::Migration[5.2]
  def change
    execute "ALTER TABLE `resourceTypes` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ENGINE=InnoDB"
    execute "ALTER TABLE `resourceTypes` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
    rename_table :resourceTypes, :resource_types
    change_table(:resource_types) { |t| t.timestamps }
    rename_column :resource_types, :ID, :id
  end
end
