class AddTimeStamps < ActiveRecord::Migration[5.2]
  def change
    change_table(:access_plain_text) { |t| t.timestamps }
    change_table(:access_types) { |t| t.timestamps }
  end
end
