class ForeignKeyAdjustDatabaseList < ActiveRecord::Migration[5.2]
  def change
    execute "ALTER TABLE database_list MODIFY vendor_id int(10) UNSIGNED"
  end
end
