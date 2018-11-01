class AlterEngineCharaset < ActiveRecord::Migration[5.2]
  def change
    execute "ALTER TABLE `access_plain_text` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ENGINE=InnoDB"
  end
end
