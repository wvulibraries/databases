class DatabasesResourceTypesChange < ActiveRecord::Migration[5.2]
  def change
    execute "ALTER TABLE `databases_resourceTypes` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ENGINE=InnoDB"
    execute "ALTER TABLE `databases_resourceTypes` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
    rename_table :databases_resourceTypes, :databases_resource_types
    change_table(:databases_resource_types) { |t| t.timestamps }
    rename_column :databases_resource_types, :ID, :id
    rename_column :databases_resource_types, :dbID, :database_id
    rename_column :databases_resource_types, :resourceID, :resource_id
  end
end
