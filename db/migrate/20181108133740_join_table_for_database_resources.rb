class JoinTableForDatabaseResources < ActiveRecord::Migration[5.2]
  def change
    rename_column :databases_resource_types, :database_id, :resource_type_id
    rename_column :databases_resource_types, :resource_id, :database_list_id
  end
end
