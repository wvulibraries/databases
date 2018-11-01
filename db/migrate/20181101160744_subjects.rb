class Subjects < ActiveRecord::Migration[5.2]
  def change
    execute "ALTER TABLE `subjects` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ENGINE=InnoDB"
    execute "ALTER TABLE `subjects` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
    change_table(:subjects) { |t| t.timestamps }
  end
end
