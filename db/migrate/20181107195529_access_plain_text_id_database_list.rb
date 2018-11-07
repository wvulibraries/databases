class AccessPlainTextIdDatabaseList < ActiveRecord::Migration[5.2]
  def change
    rename_column :database_list, :access, :access_id
  end
end
