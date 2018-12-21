class AccessDefaultToDatabaseList < ActiveRecord::Migration[5.2]
  def change
    change_column :database_list, :access, :integer, :default => 2
  end
end
