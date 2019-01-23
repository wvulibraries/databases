class CreateLandingPages < ActiveRecord::Migration[5.2]
  def change
    create_table :landing_pages do |t|
      t.text :instructions
      t.text :restrictions 
      t.text :html_links
      t.string :contact_name 
      t.string :contact_position 
      t.string :contact_email
      t.string :contact_phone_number
      t.timestamps
    end
  end
end
