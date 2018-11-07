class ForeignKeyDatabaseList < ActiveRecord::Migration[5.2]
  def change
    rename_column :database_list, :vendor, :vendor_id
  end
end
