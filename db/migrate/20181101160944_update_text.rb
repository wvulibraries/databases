class UpdateText < ActiveRecord::Migration[5.2]
  def change
    execute "ALTER TABLE `updateText` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ENGINE=InnoDB"
    execute "ALTER TABLE `updateText` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
    rename_table :updateText, :update_text
    change_table(:update_text) { |t| t.timestamps }
    rename_column :update_text, :ID, :id
    rename_column :subjects, :ID, :id
  end
end
