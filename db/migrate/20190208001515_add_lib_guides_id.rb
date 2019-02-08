class AddLibGuidesId < ActiveRecord::Migration[5.2]
  def change
    add_column :database_list, :libguides_id, :integer
  end
end
