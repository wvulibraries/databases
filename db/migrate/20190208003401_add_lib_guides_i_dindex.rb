class AddLibGuidesIDindex < ActiveRecord::Migration[5.2]
  def change
    add_index :database_list, :libguides_id, unique: true
  end
end
