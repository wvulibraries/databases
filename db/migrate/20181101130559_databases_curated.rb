class DatabasesCurated < ActiveRecord::Migration[5.2]
  def change
    execute "ALTER TABLE `databases_curated` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ENGINE=InnoDB"
    execute "ALTER TABLE `databases_curated` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
    change_table(:databases_curated) { |t| t.timestamps }
    rename_column :databases_curated, :ID, :id
    rename_column :databases_curated, :dbID, :database_id
    rename_column :databases_curated, :subjectID, :subject_id
  end
end
