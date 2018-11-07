class ForeignKeyAdjust2DatabaseList < ActiveRecord::Migration[5.2]
  def change
    execute "ALTER TABLE `database_list` 
    ADD CONSTRAINT `fk_vendor_id` FOREIGN KEY (`vendor_id`) 
    REFERENCES `vendors`(`id`);"
  end
end
