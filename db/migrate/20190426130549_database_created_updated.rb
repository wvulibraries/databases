class DatabaseCreatedUpdated < ActiveRecord::Migration[5.2]
  def change
    change_table(:users) { |t| t.timestamps }
  end
end
