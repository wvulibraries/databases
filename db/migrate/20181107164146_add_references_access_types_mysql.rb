class AddReferencesAccessTypesMysql < ActiveRecord::Migration[5.2]
  def change
    execute "ALTER TABLE `access_types` ADD `database_list_id` int(10) UNSIGNED"
    execute "ALTER TABLE `access_types` 
    ADD CONSTRAINT `fk_database_list_id` FOREIGN KEY (`database_list_id`)
    REFERENCES `database_list`(`id`);"
  end
end
