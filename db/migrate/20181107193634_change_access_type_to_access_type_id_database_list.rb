class ChangeAccessTypeToAccessTypeIdDatabaseList < ActiveRecord::Migration[5.2]
  def change
    rename_column :database_list, :access_type, :access_type_id
  end
end
