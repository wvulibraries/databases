class RemoveDatabaseColumnAcessTypes < ActiveRecord::Migration[5.2]
  def change
    remove_column :access_types, :database_list_id
  end
end
