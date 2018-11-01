class ChangeAccessPlainText < ActiveRecord::Migration[5.2]
  def self.up
    execute "ALTER DATABASE `#{ActiveRecord::Base.connection.current_database}` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
  end
  def change
    rename_table :accessPlainText, :access_plain_text
  end
end
