class BooleansDatabaseList < ActiveRecord::Migration[5.2]
  def change
    change_column :database_list, :popular, :boolean
    change_column :database_list, :full_text_db, :boolean
    change_column :database_list, :new_database, :boolean
    change_column :database_list, :trial_database, :boolean
    change_column :database_list, :alumni, :boolean
  end
end
