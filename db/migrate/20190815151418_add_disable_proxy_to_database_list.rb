class AddDisableProxyToDatabaseList < ActiveRecord::Migration[5.2]
  def change
    add_column :database_list, :disable_proxy, :boolean, default: false
  end
end
