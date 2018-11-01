class AccessPlainTextPrimaryKeyChange < ActiveRecord::Migration[5.2]
  def change
    rename_column :access_plain_text, :ID, :id
  end
end
