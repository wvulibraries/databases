class AccessPlainTextId < ActiveRecord::Migration[5.2]
  def change
    rename_column :database_list, :access_id, :access_plain_text_id
  end
end
