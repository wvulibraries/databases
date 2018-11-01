class Vendors < ActiveRecord::Migration[5.2]
  def change
    execute "ALTER TABLE `vendors` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ENGINE=InnoDB"
    execute "ALTER TABLE `vendors` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
    change_table(:vendors) { |t| t.timestamps }
    rename_column :vendors, :ID, :id
  end
end
