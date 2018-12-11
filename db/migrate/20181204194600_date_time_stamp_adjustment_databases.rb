class DateTimeStampAdjustmentDatabases < ActiveRecord::Migration[5.2]
  def change
    add_column :database_list, :trial_expiration_date, :datetime
  end
end
