class MistakesWereMade < ActiveRecord::Migration[5.2]
  def change
    rename_column :databases_resource_types, :resource_type_id, :database_id
    rename_column :databases_resource_types, :database_list_id, :resource_id
  end
end
