class News < ActiveRecord::Migration[5.2]
  def change
    execute "ALTER TABLE `news` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ENGINE=InnoDB"
    execute "ALTER TABLE `news` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
    change_table(:news) { |t| t.timestamps }
    rename_column :news, :ID, :id
  end
end
