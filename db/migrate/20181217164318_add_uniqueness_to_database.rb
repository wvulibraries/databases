class AddUniquenessToDatabase < ActiveRecord::Migration[5.2]
  def change
    rename_column :database_list, :url_id, :url_uuid
    add_index :database_list, :url_uuid, unique: true
  end
end
