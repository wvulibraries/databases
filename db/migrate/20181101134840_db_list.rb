class DbList < ActiveRecord::Migration[5.2]
  def change
    execute "ALTER TABLE `dbList` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ENGINE=InnoDB"
    execute "ALTER TABLE `dbList` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
  end
end
