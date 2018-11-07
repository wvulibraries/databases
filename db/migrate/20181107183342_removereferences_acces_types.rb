class RemovereferencesAccesTypes < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :access_types, name: "fk_database_list_id"
  end
end
