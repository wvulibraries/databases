class ChangeDefaultsInColumns < ActiveRecord::Migration[5.2]
  def change
    execute "ALTER TABLE `access_types` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
    execute "ALTER TABLE `access_plain_text` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
  end
end
