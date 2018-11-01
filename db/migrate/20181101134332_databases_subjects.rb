class DatabasesSubjects < ActiveRecord::Migration[5.2]
  def change
    execute "ALTER TABLE `databases_subjects` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ENGINE=InnoDB"
    execute "ALTER TABLE `databases_subjects` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
    change_table(:databases_subjects) { |t| t.timestamps }
    rename_column :databases_subjects, :ID, :id
    rename_column :databases_subjects, :dbID, :database_id
    rename_column :databases_subjects, :subjectID, :subject_id
  end
end
