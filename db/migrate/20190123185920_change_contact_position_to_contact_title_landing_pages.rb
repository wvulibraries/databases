class ChangeContactPositionToContactTitleLandingPages < ActiveRecord::Migration[5.2]
  def change
    rename_column :landing_pages, :contact_position, :contact_title
  end
end
